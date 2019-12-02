countCourse <- function(student) {
  max_clique <- ncol(student);
  number_course <- 0
  for (i in 1:number_student) {
    for (j in 1:max_clique)
      number_course <- pmax(number_course, student[i,j])
  }
  return(number_course)
}


conflictMatrix <- function(student, number_course){
  matrixC <- matrix(0, nrow=number_course, ncol=number_course)
  colnames(matrixC) <- 1:number_course
  max_clique = ncol(student);
  
  for (stud in 1:nrow(student)) {
    for (i in 1:(max_clique-1)) {
      for (j in (i+1):max_clique) {
        a = student[stud,i];
        b = student[stud,j];
        if (b == 0 | a == b) { break; }
        matrixC[a,b] = matrixC[a,b]+1;
        matrixC[b,a] = matrixC[b,a]+1;
      }
      if (student[stud,i] == 0) { break; }
    }
  }
  
  return(matrixC)
}

degreeMatrix <- function(student, number_course){
  matrixD <- matrix(0, nrow=number_course, ncol=number_course)
  colnames(matrixD) <- 1:number_course
  max_clique = ncol(student);
  
  for (stud in 1:nrow(student)) {
    for (i in 1:(max_clique-1)) {
      for (j in (i+1):max_clique) {
        a = student[stud,i];
        b = student[stud,j];
        if (b == 0 | a == b) { break; }
        matrixD[a,b] = 1;
        matrixD[b,a] = 1;
      }
      if (student[stud,i] == 0) { break; }
    }
  }
  
  return(matrixD)
}

countDegree <- function(degreeMatrix) {
  tot_degree <- apply(degreeMatrix,1,sum)
  tot_degree <- as.data.frame(tot_degree)
  tot_degree$Course <- seq.int(nrow(tot_degree))
  tot_degree <- tot_degree[, c(2,1)]
  tot_degree_2 <- tot_degree[order(-tot_degree[2]), ] #mengurutkan agar largest degree diatas
  tot_degree_3 <- as.matrix(tot_degree_2)
  return(tot_degree_3)
}

scheduling <- function(number_course, tot_degree_3, degreeMatrix) {
  number_timetable <- 1
  course_tt <- cbind(c(1:number_course), 0)
  
  timetableMatrix <- matrix(0, nrow=1, ncol=number_course)
  colnames(timetableMatrix) <- 1:number_course
  
  for (total_coursee in 1:number_course) {
    current_course = tot_degree_3[total_coursee][1];
    #timeslot = 1;
    for (per_tt in 1:number_timetable) {
      break_tt = FALSE;
      #cari matkul yang ada di totalcourse, terus cek tiap timeslot, dan per 
      for (slot_tt in 1:number_course) {
        current_course2 = timetableMatrix[per_tt,slot_tt];
        
        #kalau slot kosong
        if (current_course2 == 0) {
          timetableMatrix[per_tt,slot_tt] = current_course;
          break_tt = TRUE;
          break;
        }
        
        #kalau di slotnya nggak kosong, dicek degree nya
        degree = degreeMatrix[current_course,current_course2];
        if (degree > 0) { break; }
      }
      
      if (break_tt) {break} else if (per_tt == number_timetable) {
        number_timetable<-number_timetable + 1;
        timetableMatrix<-rbind(timetableMatrix, c(0));
        timetableMatrix[number_timetable,1] = current_course;
      }
    }
  }
  
  return(timetableMatrix)
}

createScheduling <- function(timetableMatrix, number_course) {
  course_tt <- cbind(c(1:number_course), 0)
  
  for (i in 1:nrow(timetableMatrix)) {
    for (j in 1:ncol(timetableMatrix)) {
      if (timetableMatrix[i,j] > 0) {
        course_tt[timetableMatrix[i,j], 2] <- i-1
      }
    }
  }
  
  return(course_tt)
}

checkDegreeRandom <- function(randomExam, randomTT, timetableMatrix, conflictMatrix) {
  timeslot <- as.matrix(timetableMatrix[randomTT, ])
  timeslot <- as.matrix(timeslot[rowSums(timeslot != 0) > 0, ])
  for (i in 1:nrow(timeslot)) {
    if (conflictMatrix[randomExam, timeslot[i]] > 0) {
      return(FALSE)
    }
  }
  return(TRUE)
}

save_output <- function(nama_file_output, course_tt) {
  write.table(course_tt, file=nama_file_output, row.names=FALSE, col.names=FALSE)
}