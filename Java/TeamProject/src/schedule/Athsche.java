package schedule;

public class Athsche {
	String type;
	int days;
	String exname;
	String howto;
	int sets;
	int reps;
	
	public Athsche() {}
	public Athsche(String type, int days, String exname, String howto, int sets, int reps)
	{
		this.type = type;
		this.days = days;
		this.exname = exname;
		this.howto = howto;
		this.sets = sets;
		this.reps = reps;
	}
	
	public String getType()
	{
		return type;
	}
	public void setType(String type)
	{
		this.type = type;
	}
	public int getDays()
	{
		return days;
	}
	public void setDays(int days)
	{
		this.days = days;
	}
	public String getExname()
	{
		return exname;
	}
	public void setExname(String exname)
	{
		this.exname = exname;
	}
	public String getHowto()
	{
		return howto;
	}
	public void setHowto(String howto)
	{
		this.howto = howto;
	}
	public int getSets()
	{
		return sets;
	}
	public void setSets(int sets)
	{
		this.sets = sets;
	}
	public int getReps()
	{
		return reps;
	}
	public void setReps(int reps)
	{
		this.reps = reps;
	}
}