package test;

import com.mongodb.*;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.result.DeleteResult;
import com.mongodb.client.result.UpdateResult;
import com.mongodb.Block;
import org.bson.Document;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import static com.mongodb.client.model.Filters.*;
import static com.mongodb.client.model.Updates.*;

import java.io.IOException;
import java.lang.reflect.Array;

public class JsoupTester {
	public static void main(String[] args)
	{
		lgnLog();
		MongoClient mongoClient = new MongoClient("localhost", 27017);
		
		MongoDatabase database = mongoClient.getDatabase("sample");
		MongoCollection<Document> collection = database.getCollection("samples");
		
		String url = "https://www.zillow.com/homes/for_sale/Denver-CO/pmf,pf_pt/11093_rid/globalrelevanceex_sort/39.993693,-104.527359,39.536086,-105.185165_rect/10_zm/";
		
		org.jsoup.nodes.Document document = null;
		
		try {
			document = Jsoup.connect(url).get();
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		Elements price = document.getElementsByClass("zsg-photo-card-price");
		Elements address = document.getElementsByClass("zsg-photo-card-address");
		
		List<Document> docs = new ArrayList<Document>();
		
		for (Element temp : address) {
			docs.add(new Document("address", temp.text()).append("price", price));
		}
		collection.insertMany(docs);
		
		
		
		
		/*
		 * String url = "https://news.naver.com/";
		 * 
		 * Document document = null; try { document = Jsoup.connect(url).get(); } catch
		 * (IOException e) { // TODO Auto-generated catch block e.printStackTrace(); }
		 * Element head = document.getElementById("today_main_news"); Elements headlines
		 * = head.getElementsByTag("ul");
		 * 
		 * System.out.println(headlines);
		 * 
		 * 
		 * 
		 * System.out.println("============================="); for (Element headline :
		 * headlines) { System.out.println("Href: " + headline.attr("href")); }
		 */
		
		
//		Document doc = new Document();
//		
//		doc.append("title", "sample_title")
//		.append("body", "sample_body")
//		.append("tag", Arrays.asList("java", "mongoDB"))
//		.append("version", new Document("Java", "1.8")
//				.append("MongoDriver", "3.7"));
//		
//		collection.insertOne(doc);
		/*
		 * List<Document> docs = new ArrayList<Document>();
		 * 
		 * for (int i = 0; i < 5; i++) { docs.add(new Document("i", i).append("value",
		 * 1000*i)); }
		 * 
		 * collection.insertMany(docs);
		 */
		/*
		 * MongoCursor<Document> cursor = collection.find().iterator();
		 * 
		 * try { while (cursor.hasNext()) { System.out.println(cursor.next().toJson());
		 * } } finally { cursor.close(); } for (Document cur: collection.find()) {
		 * System.out.println(cur.toJson()); }
		 */
		
		/*
		 * for (Document cur : collection.find(gte("value", 3000))) {
		 * System.out.println(cur.toJson()); }
		 */
		
		//collection.updateOne(eq("i", 6), new Document("$set", new Document("i", 2)));
		
		//collection.updateMany(eq("i", 2), inc("i", 4));
		
		/*
		 * DeleteResult dlResult = collection.deleteOne(eq("i", 5));
		 * System.out.println(dlResult.getDeletedCount() +
		 * " document(s) have(has) been deleted");
		 */
		
		/*
		 * DeleteResult dlResult = collection.deleteMany(gte("i", 3));
		 * System.out.println(dlResult.getDeletedCount() +
		 * " document(s) have(has) been deleted");
		 */
	}
	
	public static void lgnLog() {
		Logger mongoLogger = Logger.getLogger("org.mongodb.driver");
		mongoLogger.setLevel(Level.SEVERE);
	}
}
