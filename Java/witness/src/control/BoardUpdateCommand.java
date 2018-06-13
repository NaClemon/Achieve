package control;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import control.BoardDAO;

public class BoardUpdateCommand implements BoardCommand {

   public void execute(HttpServletRequest request, HttpServletResponse response) {
      
	   String num = request.getParameter("num");
	   String mon_athle1_name = request.getParameter("mon_athle1_name");
		int mon_athle1_many = Integer.parseInt(request.getParameter("mon_athle1_many"));
		int mon_athle1_set = Integer.parseInt(request.getParameter("mon_athle1_set"));
		String mon_athle2_name = request.getParameter("mon_athle2_name");
		int mon_athle2_many = Integer.parseInt(request.getParameter("mon_athle2_many"));
		int mon_athle2_set = Integer.parseInt(request.getParameter("mon_athle2_set"));
		String mon_meal = request.getParameter("mon_meal");
		String tue_athle1_name = request.getParameter("tue_athle1_name");
		int tue_athle1_many = Integer.parseInt(request.getParameter("tue_athle1_many"));
		int tue_athle1_set = Integer.parseInt(request.getParameter("tue_athle1_set"));
		String tue_athle2_name = request.getParameter("tue_athle2_name");
		int tue_athle2_many = Integer.parseInt(request.getParameter("tue_athle2_many"));
		int tue_athle2_set = Integer.parseInt(request.getParameter("tue_athle2_set"));
		String tue_meal = request.getParameter("tue_meal");
		String wed_athle1_name = request.getParameter("wed_athle1_name");
		int wed_athle1_many = Integer.parseInt(request.getParameter("wed_athle1_many"));
		int wed_athle1_set = Integer.parseInt(request.getParameter("wed_athle1_set"));
		String wed_athle2_name = request.getParameter("wed_athle2_name");
		int wed_athle2_many = Integer.parseInt(request.getParameter("wed_athle2_many"));
		int wed_athle2_set = Integer.parseInt(request.getParameter("wed_athle2_set"));
		String wed_meal = request.getParameter("wed_meal");
		String thu_athle1_name = request.getParameter("thu_athle1_name");
		int thu_athle1_many = Integer.parseInt(request.getParameter("thu_athle1_many"));
		int thu_athle1_set = Integer.parseInt(request.getParameter("thu_athle1_set"));
		String thu_athle2_name = request.getParameter("thu_athle2_name");
		int thu_athle2_many = Integer.parseInt(request.getParameter("thu_athle2_many"));
		int thu_athle2_set = Integer.parseInt(request.getParameter("thu_athle2_set"));
		String thu_meal = request.getParameter("thu_meal");
		String fri_athle1_name = request.getParameter("fri_athle1_name");
		int fri_athle1_many = Integer.parseInt(request.getParameter("fri_athle1_many"));
		int fri_athle1_set = Integer.parseInt(request.getParameter("fri_athle1_set"));
		String fri_athle2_name = request.getParameter("fri_athle2_name");
		int fri_athle2_many = Integer.parseInt(request.getParameter("fri_athle2_many"));
		int fri_athle2_set = Integer.parseInt(request.getParameter("fri_athle2_set"));
		String fri_meal = request.getParameter("fri_meal");
		String sat_athle1_name = request.getParameter("sat_athle1_name");
		int sat_athle1_many = Integer.parseInt(request.getParameter("sat_athle1_many"));
		int sat_athle1_set = Integer.parseInt(request.getParameter("sat_athle1_set"));
		String sat_athle2_name = request.getParameter("sat_athle2_name");
		int sat_athle2_many = Integer.parseInt(request.getParameter("sat_athle2_many"));
		int sat_athle2_set = Integer.parseInt(request.getParameter("sat_athle2_set"));
		String sat_meal = request.getParameter("sat_meal");
		String sun_athle1_name = request.getParameter("sun_athle1_name");
		int sun_athle1_many = Integer.parseInt(request.getParameter("sun_athle1_many"));
		int sun_athle1_set = Integer.parseInt(request.getParameter("sun_athle1_set"));
		String sun_athle2_name = request.getParameter("sun_athle2_name");
		int sun_athle2_many = Integer.parseInt(request.getParameter("sun_athle2_many"));
		int sun_athle2_set = Integer.parseInt(request.getParameter("sun_athle2_set"));
		String sun_meal = request.getParameter("sun_meal");
      
      
      BoardDAO dao = new BoardDAO();
      dao.update(num, mon_athle1_name, mon_athle1_many, mon_athle1_set, mon_athle2_name, mon_athle2_many, mon_athle2_set, mon_meal,
				tue_athle1_name, tue_athle1_many, tue_athle1_set, tue_athle2_name, tue_athle2_many, tue_athle2_set, tue_meal,
				wed_athle1_name, wed_athle1_many, wed_athle1_set, wed_athle2_name, wed_athle2_many, wed_athle2_set, wed_meal,
				thu_athle1_name, thu_athle1_many, thu_athle1_set, thu_athle2_name, thu_athle2_many, thu_athle2_set, thu_meal,
				fri_athle1_name, fri_athle1_many, fri_athle1_set, fri_athle2_name, fri_athle2_many, fri_athle2_set, fri_meal,
				sat_athle1_name, sat_athle1_many, sat_athle1_set, sat_athle2_name, sat_athle2_many, sat_athle2_set, sat_meal,
				sun_athle1_name, sun_athle1_many, sun_athle1_set, sun_athle2_name, sun_athle2_many, sun_athle2_set, sun_meal);
   }
}