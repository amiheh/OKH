load("penalty.R");

data_name = matrix(c("car-s-91", "Carleton91", 
                     "car-f-92", "Carleton92", 
                     "ear-f-83", "EarlHaig83", 
                     "hec-s-92", "EdHEC92", 
                     "kfu-s-93", "KingFahd93", 
                     "lse-f-91", "LSE91", 
                     "pur-s-93", "pur-s-93", 
                     "rye-s-93", "rye-s-93", 
                     "sta-f-83", "St.Andrews83", 
                     "tre-s-92", "Trent92", 
                     "uta-s-92", "TorontoAS92", 
                     "ute-s-92", "TorontoE92", 
                     "yor-f-83", "YorkMills83"), ncol=2, byrow=TRUE)

for (dat in 1:nrow(data_name)) {
  if (dat == 1) {
    cat("Daftar universitas: \n");
  }
  cat(dat, ". ", data_name[dat,1], " \n");
}

pilihan <- readline("Pilih universitas mana yang akan dijadwalkan: ")

start_time <- Sys.time()

#asumsi tiap anak maks ambil exam 20
nama_file_input <- paste(data_name[as.integer(pilihan), 1], '.stu', sep="")
student <- read.csv(nama_file_input, header=FALSE, sep=" ", col.names = paste0("V",seq_len(20)))
student[is.na(student)] <- 0

number_student = nrow(student);
max_clique = ncol(student);
number_timetable = 1;

#menghitung jumlah course
number_course <- 0
for (i in 1:number_student) {
  for (j in 1:max_clique)
    number_course <- pmax(number_course, student[i,j])
}
number_course <- as.integer(number_course);

conflictMatrix <- matrix(0, nrow=number_course, ncol=number_course)
colnames(conflictMatrix) <- 1:number_course
degreeMatrix <- matrix(0, nrow=number_course, ncol=number_course)
colnames(degreeMatrix) <- 1:number_course

for (stud in 1:number_student) {
  for (i in 1:(max_clique-1)) {
    for (j in (i+1):max_clique) {
      a = student[stud,i];
      b = student[stud,j];
      if (b == 0 | a == b) { break; }
      conflictMatrix[a,b] = conflictMatrix[a,b]+1;
      conflictMatrix[b,a] = conflictMatrix[b,a]+1;
      degreeMatrix[a,b] = 1;
      degreeMatrix[b,a] = 1;
    }
    if (student[stud,i] == 0) { break; }
  }
}

#menghitung degree
tot_degree <- apply(degreeMatrix,1,sum)
tot_degree <- as.data.frame(tot_degree)
tot_degree$Course <- seq.int(nrow(tot_degree))
tot_degree <- tot_degree[, c(2,1)]
tot_degree_2 <- tot_degree[order(-tot_degree[2]), ] #mengurutkan agar largest degree diatas
tot_degree_3 <- as.matrix(tot_degree_2)

course_tt <- cbind(c(1:number_course), 0)

timetableMatrix <- matrix(0, nrow=number_timetable, ncol=number_course)
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
        course_tt[current_course,2] = per_tt-1;
        break_tt = TRUE;
        break;
      }
      
      #kalau di slotnya nggak kosong, dicek degree nya
      degree = degreeMatrix[current_course,current_course2];
      if (degree > 0) { break; }
    }
    
    if (break_tt) {break} else if (per_tt == number_timetable) {
      course_tt[current_course,2] = number_timetable;
      number_timetable<-number_timetable + 1;
      timetableMatrix<-rbind(timetableMatrix, c(0));
      timetableMatrix[number_timetable,1] = current_course;
    }
  }
}
timetableMatrix<-timetableMatrix[, colSums(timetableMatrix != 0) > 0]

View(course_tt);
print(nrow(timetableMatrix));
print(penalty(conflictMatrix, course_tt, number_student))

nama_file_output = paste(data_name[as.integer(pilihan), 2], '.sol', sep="");
write.table(course_tt, file=nama_file_output, row.names=FALSE, col.names=FALSE)
end_time <- Sys.time()

time <- end_time - start_time;
print(time)