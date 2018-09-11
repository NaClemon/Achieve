package haker;

public class BoardDTO {

   
   int num;
   String author;
   String title;
   String content;
   String nickname;
   String age;
   int readcnt;
   String writeday;
   int repRoot;
   int repStep;
   int repIndent;
   
   public BoardDTO() {}
   public BoardDTO(int num, String author, String nickname, String age, String title,String content, int readcnt,String writeday,int repStep,int repIndent, int repRoot)
   {
      this.num=num;
      this.author=author;
      this.title=title;
      this.content=content;
      this.readcnt=readcnt;
      this.nickname=nickname;
      this.age=age;
      this.writeday=writeday;
      this.repRoot= repRoot;
      this.repStep=repStep;
      this.repIndent=repIndent;
   }
   
   public int getNum()
   {
      return num;
   }
   
   public void setNum(int num)
   {
      this.num=num;
   }
   
   public String getAuthor() {
      return author;
   }
   
   public void setAuthor(String author) {
      this.author=author;
   }
   public String getTitle() {
      return title;
   }
   public void setTitle(String title) {
      this.title=title;
   }
   public String getContent()
   {
      return content;
   }
   public void setContent(String content) {
      this.content=content;
   }
   public int getReadcnt() {
      return readcnt;
   }
   public void setReadcnt(int readcnt) {
      this.readcnt=readcnt;
   }
   public String getNickname() {
	   return nickname;
   }
   public void setNickname(String nickname) {
	   this.nickname = nickname;
   }
   public String getAge() {
	   return age;
   }
   public void setAge(String age) {
	   this.age = age;
   }
   public String getWriteday() {
      return writeday;
   }
   public void setWriteday(String writeday) {
      this.writeday=writeday;
   }
   public int getRepRoot() {
      return repRoot;
   }
   public void setRepRoot(int repRoot) {
      this.repRoot=repRoot;
   }
   public int getRepStep() {
      return repStep;
   }
   public void setRepStep(int repStep) {
      this.repStep=repStep;
   }
   public int getRepIndent() {
      return repIndent;
   }
   public void setRepIndent(int reIndent) {
      this.repIndent=reIndent;
   }
   
}