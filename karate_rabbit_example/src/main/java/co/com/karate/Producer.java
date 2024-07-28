package co.com.karate;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.concurrent.TimeoutException;
public class Producer {
    private static final Logger logger = LoggerFactory.getLogger(Producer.class);
    public static String QUEUE_NAME = "MyQueue";
    ConnectionFactory factory = new ConnectionFactory();
    Connection connection;
    static Channel channel;

    {
        try {
            connection = factory.newConnection();
            factory.setUsername("guest");
            factory.setPassword("guest");
            factory.setHost("localhost");
            factory.setPort(5672);
            channel = connection.createChannel();
            channel.queueDeclare(QUEUE_NAME, false, false, false, null);
            logger.info("Initialised RMQ");
        } catch (IOException | TimeoutException e) {
            throw new RuntimeException(e);
        }
    }

    public void putMessage(String msg) throws IOException {
        channel.basicPublish("", QUEUE_NAME, null, msg.getBytes());
        System.out.println(" [x] Sent '" + msg + "'");
    }

    public static void main(String[] args) throws IOException {
        Producer p = new Producer();
        //Sample json messages into the queue
        channel.queueDeclare(QUEUE_NAME, false, false, false, null);
        for (int i = 1; i <= 10; i++)
        {
            JSONObject obj = new JSONObject();
            obj.put("name", String.format("Person%s", i));
            obj.put("age", 37);

            channel.basicPublish("", QUEUE_NAME, null, obj.toString().getBytes());
            System.out.println(" [x] Sent '" + obj.toString() + "'");
        }

    }
}
