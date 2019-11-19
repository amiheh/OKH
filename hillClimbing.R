hillClimbing <- function(course_tt, conflictMatrix, number_student, number_course, number_iteration, number_timetable) {
  course_tt_2 <- course_tt;
  proximity <- penalty(conflictMatrix, course_tt, number_student);
  first_proximity <- proximity;
  for(it in 1:number_iteration)
  {
    randomExam = floor(runif(1, min=1, max=number_course));
    randomTT = floor(runif(1, min=0, max=number_timetable));
    if(checkDegreeRandom(randomExam, randomTT+1, timetableMatrix, conflictMatrix))
    {
      course_tt_2[randomExam,2] <- randomTT;
      proximity_2 = penalty(conflictMatrix, course_tt_2, number_student);
      if(proximity_2<proximity)
      {
        proximity = penalty(conflictMatrix, course_tt_2, number_student);
        course_tt[randomExam,2] <- course_tt_2[randomExam,2];
      }
      else
      {
        course_tt_2[randomExam,2] <- course_tt[randomExam,2];
      }
    } 
    cat("Iterasi: ", it, " Proximity: ", penalty(conflictMatrix, course_tt, number_student), "\n");
  }
  cat("Penalti Solusi Awal = ", first_proximity);
  cat("\nSolusi terbaik adalah = ", proximity);
  
  return(course_tt)
}