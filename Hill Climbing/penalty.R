penalty<-function (conflictMatrix, course_tt, number_student) {
  penalty2 = 0;
  row = nrow(conflictMatrix);
  for (i in 1:(row-1)) {
    for (j in (i+1):row) {
      if(conflictMatrix[i,j]>0)
      {
        if(abs(course_tt[j,2]-course_tt[i,2])>=1 && abs(course_tt[j,2]-course_tt[i,2])<=5)
        {
          penalty2 = penalty2 + (conflictMatrix[i,j]*(2 ^ (5-(abs(course_tt[j,2]-course_tt[i,2])))));
        }						
      }
    }
  }
  return(penalty2/number_student);
}