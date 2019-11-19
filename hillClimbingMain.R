source("penalty.R");
source("function.R");
source("hillClimbing.R");

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

first_start <- Sys.time()

#asumsi tiap anak maks ambil exam 20
nama_file_input <- paste(data_name[as.integer(pilihan), 1], '.stu', sep="")
student <- read.csv(nama_file_input, header=FALSE, sep=" ", col.names = paste0("V",seq_len(20)))
student[is.na(student)] <- 0

number_student = nrow(student);
max_clique = ncol(student);
number_timetable = 1;

number_course <- countCourse(student)
conflictMatrix <- conflictMatrix(student, number_course);
degreeMatrix <- degreeMatrix(student, number_course);
tot_degree_3 <- countDegree(degreeMatrix);
timetableMatrix <- scheduling(number_course, tot_degree_3, degreeMatrix);
course_tt <- createScheduling(timetableMatrix, number_course);

cat("Jumlah timetable awal: ", nrow(timetableMatrix));
cat("\nPenalty awal: ", penalty(conflictMatrix, course_tt, number_student));
cat("\n");

number_iteration <- readline("Masukkan jumlah iterasi yang akan dilakukan: ")

second_start <- Sys.time();

number_timetable = nrow(timetableMatrix);
course_tt_2 <- hillClimbing(course_tt, conflictMatrix, number_student, number_course, number_iteration, number_timetable)

nama_file_output = paste(data_name[as.integer(pilihan), 2], '.sol', sep="");
save_output(nama_file_output, course_tt_2)

time <- Sys.time() - first_start;
cat("\n\nWaktu dengan pembuatan initial solution: ", time, "\n")
hill_time <- Sys.time() - second_start;
cat("Waktu tanpa pembuatan initial solution: ", hill_time, "\n")