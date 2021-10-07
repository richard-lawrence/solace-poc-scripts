//
// Example JCSMP Queue Receiver to demonstrate:
//
//	- Binding and reading from persistent queue
//	- Flow indicator handling
//	- Message replay handling
//	- Message type handling
//	- Exception handling
//	- API logging (see log4j.properties)
//	- Session Event handling
//
//	Note rebind logic on flow down (for queue shutdown, replay) not required with JCSMP 10.7.0+
//
//

import java.util.Vector;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.CountDownLatch;

import org.apache.log4j.Logger;

import com.solacesystems.jcsmp.*;


public class JcsmpQueueReceiver
{

    protected 	SimpleDateFormat m_dateFormat = 
            new SimpleDateFormat("EEE MMM dd HH:mm:ss");
 
    protected String m_url = "localhost:55555";
    protected String m_username = "admin";
    protected String m_password = "admin";
    protected String m_vpn  =  "default";
    protected String m_queueName  =  "test-queue";
    protected String m_topicSub  =  null;
    protected boolean m_createQ = false;
    protected boolean m_debug = false;
    protected int m_delay = 30;


    protected JCSMPSession m_session = null;
    protected FlowReceiver m_flow = null;
    protected QMessageListener m_qMessageListener = null;
    protected SessionEventHandler m_sessionHandler = null;

    protected Queue m_queue = null;
    protected volatile int replayErrorResponseSubcode = JCSMPErrorResponseSubcodeEx.UNKNOWN;
 
    protected static final Logger log = Logger.getLogger(JcsmpQueueReceiver.class);
 

    public void usage()
    {
        System.out.println("\nUsage: java JcsmpQueueReceiver [options]");
	System.out.println("");
        System.out.println("   where options are:");
        System.out.println("");
        System.out.println("  -url    	<URL>			- Solace broker URL (default localhost:55555)");
        System.out.println("  -username <Username>		- Solace broker usnername (default admin)");
        System.out.println("  -password	<Password>		- Solace broker password (default admin)");
        System.out.println("  -vpn	<VPN Name>		- Solace broker VPN name (default: default )");
        System.out.println("  -queue	<Queue Name>		- Queue to read");
        System.out.println("  -create				- Create queue (default do not create queue)");
        System.out.println("  -sub      <Topic>			- if create enabled add optional topic subscription");
        System.exit(0);
    }

    public JcsmpQueueReceiver()
    {
    }

    public void init()
    {
	try
	{
	    // create session (connection to broker)
	    JCSMPProperties properties = new JCSMPProperties();
	    properties.setProperty(JCSMPProperties.HOST, m_url);
	    properties.setProperty(JCSMPProperties.USERNAME, m_username);
	    properties.setProperty(JCSMPProperties.PASSWORD, m_password);
	    properties.setProperty(JCSMPProperties.VPN_NAME,  m_vpn);

	    // Override the default reconnect paramas
	    JCSMPChannelProperties cp = (JCSMPChannelProperties) properties
		    .getProperty(JCSMPProperties.CLIENT_CHANNEL_PROPERTIES);
	        
	    // Set number of reconnect retries (default is 3)
	    cp.setReconnectRetries(120);

	    // Set number of reconnect retry wait (default is 3000 millis)
	    cp.setReconnectRetryWaitInMillis(5000);

	    m_sessionHandler = new MySessionEventHandler();

	    m_session = JCSMPFactory.onlyInstance().createSession(properties, null, m_sessionHandler);
	    m_session.connect();

	    if (!m_session.isCapable(CapabilityType.MESSAGE_REPLAY))
		log.warn("init: ERROR session is not capable for replay");


	    m_queue = JCSMPFactory.onlyInstance().createQueue(m_queueName);

	    // Create queue
	    if (m_createQ)
	    {
		EndpointProperties ep_props = new EndpointProperties();
		// Set permissions to allow all.
		ep_props.setPermission(EndpointProperties.PERMISSION_CONSUME);
		// Set access type to exclusive.
		ep_props.setAccessType(EndpointProperties.ACCESSTYPE_EXCLUSIVE);
		m_session.provision(m_queue, ep_props, JCSMPSession.FLAG_IGNORE_ALREADY_EXISTS);

		// Add subscriptions if required:
		if (m_topicSub != null)
		{
		    Topic topSub = JCSMPFactory.onlyInstance().createTopic(m_topicSub);
		    m_session.addSubscription(m_queue, topSub, JCSMPSession.WAIT_FOR_CONFIRM);
		}
	    }

	    m_qMessageListener = new QMessageListener();

	}
	catch(JCSMPException ie)
	{
	    log.error("init: Exception: "+ie.getMessage());
	}
    }
    public void run()
    {
	try
	{
	    while (true)
	    {
		if (m_flow == null)
		{
		    bindToQ();
		}
		Thread.sleep(m_delay*1000);
	    }
	}
	catch(Exception ie)
	{
	    log.error("run: Exception: "+ie.getMessage());
	}

	unbindFromQ();

	if (m_session != null)
	    m_session.closeSession();
    }

    public class QMessageListener implements XMLMessageListener
    {
	public void onReceive(BytesXMLMessage msg)
	{
	    if (msg != null)
	    {
		String dest = msg.getDestination().getName();
		boolean isQueue = msg.getDestination() instanceof Queue;

		if (msg instanceof TextMessage)
		{
		    log.info("QListener: received msg type: TextMessage id: "+msg.getMessageId()+" from: "+(isQueue?"Queue: ":"Topic: ")+dest);

		    // Use getText() to read the message content
		    String text = ((TextMessage)msg).getText();
                }
		else if (msg instanceof MapMessage)
		{
		    log.info("QListener: received msg type: MapMessage id: "+msg.getMessageId()+" from: "+(isQueue?"Queue: ":"Topic: ")+dest);

		    // Use getMap() to read the message content
		    SDTMap map = ((MapMessage)msg).getMap();
                }
		else if (msg instanceof XMLContentMessage)
		{
		    log.info("QListener: received msg type: XMLContentMessage id: "+msg.getMessageId()+" from: "+(isQueue?"Queue: ":"Topic: ")+dest);

		    // Use getXMLContent() to read the message content
		    String xml = ((XMLContentMessage)msg).getXMLContent();
                }
		else if (msg instanceof BytesMessage)
		{
		    log.info("QListener: received msg type: BytesMessage id: "+msg.getMessageId()+" from: "+(isQueue?"Queue: ":"Topic: ")+dest);

		    // Use getData() to read the message content
		    byte[] bytes = ((BytesMessage)msg).getData();
                }
		else if (msg instanceof StreamMessage)
		{
		    log.info("QListener: received msg type: StreamMessage id: "+msg.getMessageId()+" from: "+(isQueue?"Queue: ":"Topic: ")+dest);

		    // Use getStream() to read the message content
		    SDTStream stream = ((StreamMessage)msg).getStream();
                }
		else
		{
		    log.info("QListener: received unrecognised msg type:" +msg.getClass().getName()+" id: "+msg.getMessageId()+" from: "+(isQueue?"Queue: ":"Topic: ")+dest);
                }
 
		log.debug("Msg dump:\n"+ msg.dump());

		msg.ackMessage();

		//
		// Dont block this thread, no futher messages will be delivered until this method returns
		//
		/**
		try
		{
		    Thread.sleep(1000*10);
		}
		catch(Exception ie)
		{
		    log.error("QListener: "+ ie);
		}
		**/


	    }
	    else
	    {
		log.error("QListener: msg is null");
	    }
	}

	public void onException(JCSMPException e)
	{
	    log.error("QListener exception: "+e);
	    if (e instanceof JCSMPFlowTransportUnsolicitedUnbindException &&  replayErrorResponseSubcode == JCSMPErrorResponseSubcodeEx.REPLAY_STARTED)
	    {
		// We get here if replay is initiated on the queue
		unbindFromQ();
		log.info("QListener: Rebinding to queue for replay...");
		bindToQ();
		replayErrorResponseSubcode = JCSMPErrorResponseSubcodeEx.UNKNOWN; // reset after handling

	    }
	    else
	    {
		unbindFromQ();
		log.info("QListener: Attempting to rebind to queue every "+m_delay+" secs...");
	    }
	}
    }
    public class QEventHandler implements FlowEventHandler
    {
	public QEventHandler ()
	{
	}
	public void handleEvent(Object o, FlowEventArgs args)
	{
	    if (args.getEvent() == FlowEvent.FLOW_ACTIVE)
	    {
		log.info("QEventHandler: FLOW ACTIVE");
	    }
	    else
	    if (args.getEvent() == FlowEvent.FLOW_DOWN)
	    {
		log.info("QEventHandler: "+args.toString());
                if (args.getException() instanceof JCSMPErrorResponseException)
		{
                    JCSMPErrorResponseException ex = (JCSMPErrorResponseException) args.getException();
                    // Store the subcode for the exception handler
                    replayErrorResponseSubcode = ex.getSubcodeEx();
                    // Placeholder for additional event handling
                    // Do not manipulate the session from here
                    // onException() is the correct place for that
                    switch (replayErrorResponseSubcode) {
                        case JCSMPErrorResponseSubcodeEx.REPLAY_STARTED:
                        case JCSMPErrorResponseSubcodeEx.REPLAY_FAILED:
                        case JCSMPErrorResponseSubcodeEx.REPLAY_CANCELLED:
                        case JCSMPErrorResponseSubcodeEx.REPLAY_LOG_MODIFIED:
                        case JCSMPErrorResponseSubcodeEx.REPLAY_START_TIME_NOT_AVAILABLE:
                        case JCSMPErrorResponseSubcodeEx.REPLAY_MESSAGE_UNAVAILABLE:
                        case JCSMPErrorResponseSubcodeEx.REPLAYED_MESSAGE_REJECTED:
                            break;
                        default:
                            break;
                    }
                }
	    }
	}
    }

    public class MySessionEventHandler implements SessionEventHandler
    {
	public void handleEvent(SessionEventArgs event)
	{
	    log.info("Received Session Event: "+event.getEvent()+" "+event.getInfo());
	}
    }


    public void bindToQ()
    {
	try
	{
	    // bind to Q, blocking until we are the one and only active consumer

	    log.debug("bindToQ: binding to: "+m_queueName);

	    ConsumerFlowProperties flowProps = new ConsumerFlowProperties();
	    flowProps.setEndpoint(m_queue);
	    flowProps.setStartState(true);
	    flowProps.setAckMode(JCSMPProperties.SUPPORTED_MESSAGE_ACK_CLIENT);
	    flowProps.setActiveFlowIndication(true);
	    m_flow = m_session.createFlow(m_qMessageListener, flowProps, null, new QEventHandler());

	}
	catch(Exception ie)
	{
	    log.error("bindToQ: Exception: "+ie.getMessage());
	}
    }

    public void unbindFromQ()
    {
	if (m_flow != null)
	    m_flow.close();
	m_flow = null;
    }

    public static void main(String[] args) {
        JcsmpQueueReceiver r = new JcsmpQueueReceiver();
	try
	{
	    r.parseModuleArgs(args);
	    r.init();
	    r.run();
	}
	catch(Exception ie)
	{
	    log.error("Main: Exception: "+ie.getMessage());
	}
    }

    public void parseModuleArgs(String[] args)
    {
	int i=0;

        while(i < args.length)
        {
            if (args[i].compareTo("-debug")==0)
            {
                m_debug = true;
		i += 1;
            }
            else
            if (args[i].compareTo("-url")==0)
            {
                if ((i+1) >= args.length) usage();
                m_url = args[i+1];
		i += 2;
            }
            else
            if (args[i].compareTo("-username")==0)
            {
                if ((i+1) >= args.length) usage();
                m_username = args[i+1];
		i += 2;
            }
            else
            if (args[i].compareTo("-password")==0)
            {
                if ((i+1) >= args.length) usage();
                m_password = args[i+1];
		i += 2;
            }
            else
            if (args[i].compareTo("-vpn")==0)
            {
                if ((i+1) >= args.length) usage();
                m_vpn = args[i+1];
		i += 2;
            }
            else
            if (args[i].compareTo("-queue")==0)
            {
                if ((i+1) >= args.length) usage();
                m_queueName = args[i+1];
		i += 2;
            }
	    else
            if (args[i].compareTo("-create")==0)
            {
                m_createQ = true;
		i += 1;
            }
	    else
            if (args[i].compareTo("-sub")==0)
            {
                if ((i+1) >= args.length) usage();
                m_topicSub = args[i+1];
		i += 2;
            }
            else
            {
                usage();
            }
        }
    }
}
