package co.com.karate;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.DeliverCallback;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeoutException;
public class Consumer {
    private final static String QUEUE_NAME = "MyQueue";
    ConnectionFactory factory = new ConnectionFactory();
    Connection connection = factory.newConnection();
    Channel channel = connection.createChannel();
    public static List<String> messageList = new ArrayList<>();

    public Consumer() throws IOException, TimeoutException {
        factory.setHost("localhost");
        channel.queueDeclare(QUEUE_NAME, false, false, false, null);
        System.out.println(" [*] Waiting for messages. To exit press CTRL+C");

    }
    public void listen() throws IOException {
        DeliverCallback deliverCallback = (consumerTag, delivery) -> {
            String str= new String(delivery.getBody(), StandardCharsets.UTF_8);
            System.out.println(" [x] Received '" + str + "'");
            messageList.add(str);
        };
        channel.basicConsume(QUEUE_NAME, true, deliverCallback, consumerTag -> { });

    }

    //Returns all the messages in the queue
    public List<String> getList(){
        return messageList;
    }
}
