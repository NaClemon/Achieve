package com.dev.vo;

import com.dev.vo.*;

public class GameVO {
	
	private int game_id;
	private String game_name;
	private int game_price;
	private String game_date;
	private String game_dev;
	private String game_pub;
	private String game_cont;
	private String img_url;
	
	private int genre_id;
	private String genre_name;
	
	public int getGenre_id() {
		return genre_id;
	}
	public void setGenre_id(int genre_id) {
		this.genre_id = genre_id;
	}
	public String getGenre_name() {
		return genre_name;
	}
	public void setGenre_name(String genre_name) {
		this.genre_name = genre_name;
	}
	
	
	private String min_os;
	private String min_processor;
	private String min_mem;
	private String min_graphic;
	public int getGame_id() {
		return game_id;
	}
	public void setGame_id(int game_id) {
		this.game_id = game_id;
	}
	public String getGame_name() {
		return game_name;
	}
	public void setGame_name(String game_name) {
		this.game_name = game_name;
	}
	public int getGame_price() {
		return game_price;
	}
	public void setGame_price(int game_price) {
		this.game_price = game_price;
	}
	public String getGame_date() {
		return game_date;
	}
	public void setGame_date(String game_date) {
		this.game_date = game_date;
	}
	public String getGame_dev() {
		return game_dev;
	}
	public void setGame_dev(String game_dev) {
		this.game_dev = game_dev;
	}
	public String getGame_pub() {
		return game_pub;
	}
	public void setGame_pub(String game_pub) {
		this.game_pub = game_pub;
	}
	public String getGame_cont() {
		return game_cont;
	}
	public void setGame_cont(String game_cont) {
		this.game_cont = game_cont;
	}
	public String getImg_url() {
		return img_url;
	}
	public void setImg_url(String img_url) {
		this.img_url = img_url;
	}
	public String getMin_os() {
		return min_os;
	}
	public void setMin_os(String min_os) {
		this.min_os = min_os;
	}
	public String getMin_processor() {
		return min_processor;
	}
	public void setMin_processor(String min_processor) {
		this.min_processor = min_processor;
	}
	public String getMin_mem() {
		return min_mem;
	}
	public void setMin_mem(String min_mem) {
		this.min_mem = min_mem;
	}
	public String getMin_graphic() {
		return min_graphic;
	}
	public void setMin_graphic(String min_graphic) {
		this.min_graphic = min_graphic;
	}
}
