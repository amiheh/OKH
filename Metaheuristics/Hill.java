/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.util.*;
import java.io.*;
/**
 *
 * @author 
 */
public class Hill {
  
    public static void main(String[] args){
        
        String test_crs = "C:\\Toronto\\testing.crs";
        String test_stu = "C:\\Toronto\\testing.stu";
        
        String carf92_crs = "C:\\Toronto\\car-f-92.crs";
        String carf92_stu = "C:\\Toronto\\car-f-92.stu";

        String cars91_crs = "C:\\Toronto\\car-s-91.crs";
        String cars91_stu = "C:\\Toronto\\car-s-91.stu";

        String earf83_crs = "C:\\Toronto\\ear-f-83.crs";
        String earf83_stu = "C:\\Toronto\\ear-f-83.stu";

        String hecs92_crs = "C:\\Toronto\\hec-s-92.crs";
        String hecs92_stu = "C:\\Toronto\\hec-s-92.stu";

        String kfus93_crs = "C:\\Toronto\\kfu-s-93.crs";
        String kfus93_stu = "C:\\Toronto\\kfu-s-93.stu";

        String lsef91_crs = "C:\\Toronto\\lse-f-91.crs";
        String lsef91_stu = "C:\\Toronto\\lse-f-91.stu";

        String purs93_crs = "C:\\Toronto\\pur-s-93.crs";
        String purs93_stu = "C:\\Toronto\\pur-s-93.stu";

        String ryes93_crs = "C:\\Toronto\\rye-s-93.crs";
        String ryes93_stu = "C:\\Toronto\\rye-s-93.stu";

        String staf83_crs = "C:\\Toronto\\sta-f-83.crs";
        String staf83_stu = "C:\\Toronto\\sta-f-83.stu";

        String tres92_crs = "C:\\Toronto\\tre-s-92.crs";
        String tres92_stu = "C:\\Toronto\\tre-s-92.stu";

        String utas92_crs = "C:\\Toronto\\uta-s-92.crs";
        String utas92_stu = "C:\\Toronto\\uta-s-92.stu";

        String utes92_crs = "C:\\Toronto\\ute-s-92.crs";
        String utes92_stu = "C:\\Toronto\\ute-s-92.stu";

        String yorf83_crs = "C:\\Toronto\\yor-f-83.crs";
        String yorf83_stu = "C:\\Toronto\\yor-f-83.stu";
        
        Scanner in = new Scanner(System.in);
        System.out.println("Toronto Course Timetabling");
            System.out.println("1. CAR-F-92");
            System.out.println("2. CAR-S-91");
            System.out.println("3. EAR-F-83");
            System.out.println("4. HEC-S-92");
            System.out.println("5. KFU-S-93");
            System.out.println("6. LSE-F-91");
            System.out.println("7. PUR-S-93");
            System.out.println("8. RYE-S-93");
            System.out.println("9. STA-F-83");
            System.out.println("10. TRE-S-92");
            System.out.println("11. UTA-S-92");
            System.out.println("12. UTE-S-92");
            System.out.println("13. YOR-F-83");
            System.out.println("0. EXIT");
            
            System.out.println("ENTER NUMBER:");
            int input = in.nextInt();
            
            switch(input) {
                case 1 :
                    timetabling(carf92_crs, carf92_stu, "Carleton92");
                    break;
                case 2 :
                    timetabling(cars91_crs, cars91_stu,"Carleton91");
                    break;
                case 3 :
                    timetabling(earf83_crs, earf83_stu,"EarlHaig83");
                    break;
                case 4 :
                    timetabling(hecs92_crs, hecs92_stu,"EdHEC92");
                    break;
                case 5 :
                    timetabling(kfus93_crs, kfus93_stu,"KingFahd93");
                    break;
                case 6 :
                    timetabling(lsef91_crs, lsef91_stu,"LSE91");
                    break;
                case 7 :
                    timetabling(purs93_crs, purs93_stu,"pur93");
                    break;
                case 8 :
                    timetabling(ryes93_crs, ryes93_stu,"rye93");
                    break;
                case 9 :
                    timetabling(staf83_crs, staf83_stu,"St.Andrews83");
                    break;
                case 10 :
                    timetabling(tres92_crs, tres92_stu,"Trent92");
                    break;
                case 11 :
                    timetabling(utas92_crs, utas92_stu,"TorontoAS92");
                    break;
                case 12 :
                    timetabling(utes92_crs, utes92_stu,"TorontoE92");
                    break;
                case 13 :
                    timetabling(yorf83_crs, yorf83_stu,"YorkMills83");
                    break;
                    
        case 14 :
                    timetabling(test_crs, test_stu,"test");
                    break;
        
        case 0 :
                    System.out.println("exit");
                    break;
        default :
                    break;
        }
        
        in.close();
    }
    
    public static void timetabling(String crs, String stu, String filename){
        ArrayList<String> course; 
        //ArrayList<String> scourse;
        ArrayList<String> student;
        int[][] conflict_matrix;
        try {
            
            FileReader fcr = new FileReader(crs);
            BufferedReader cr = new BufferedReader(fcr);
            
            FileReader fst = new FileReader(stu);
            BufferedReader st = new BufferedReader(fst);
            
            
            course = new ArrayList<String>();
            //scourse = new ArrayList<String>();
            String courseLine = null;
            while((courseLine = cr.readLine()) != null) {
                    String[] arr = courseLine.split(" ");
                    course.add(arr[0]);
                    //scourse.add(arr[0]);
            }
            
            student = new ArrayList<String>();
            conflict_matrix = new int[course.size()][course.size()];
            
            String StudentLine = null;
            while((StudentLine = st.readLine()) != null) {
                String[] arr = StudentLine.split(" ");
                
                if(arr.length > 0) {
                    for(int i = 0; i < arr.length-1; i++) {
                        for(int j = i+1; j < arr.length; j++) {
                            int index1 = Integer.parseInt(arr[i]);
                            int index2 = Integer.parseInt(arr[j]);
                            
                            conflict_matrix[index1-1][index2-1]++;
                            conflict_matrix[index2-1][index1-1]++;
                        }
                    }
                }
                student.add(arr[0]);
            }
            
            int[][]degrees = new int[course.size()][2];
            for(int i=0;i<degrees.length;i++){
                degrees[i][0]=i+1;
            }
            
            int sum = 0;
            for(int i = 0; i < conflict_matrix.length; i++) {
                for(int j = 0; j < conflict_matrix.length; j++) {
                    
                    if(conflict_matrix[i][j] != 0){
                        sum++;
                    }
                }
                degrees[i][1]=sum;
                sum=0;
            }
           
            int ts=1;
            int [][] timeslot = new int[course.size()][2];
            
            int[][]sdegrees = new int[course.size()][2];    
            sdegrees=degrees;
           
            
            Arrays.sort(sdegrees, new Comparator<int[]>() { 
        @Override
        public int compare(int[] entry1, int[] entry2) { 
                    if (entry1[1] < entry2[1]) 
                        return 1; 
                    else
                        return -1; 
                  } 
                });

            //timesloting            
            
            for(int i=0; i<sdegrees.length; i++){
                    for(int j=0; j<ts; j++){
                            if(issafe(i, j, conflict_matrix, sdegrees, timeslot)){
                                    timeslot[sdegrees[i][0]-1][1] = j;
                                    break;
                            }else{
                                    ts++;
                            }
                    }
            }
             
            
            //export
            
            
            ///////////////////////////////////////////////////////////////////
            //penalty cij
            double penalty = 0;
            penalty = penalty(conflict_matrix,timeslot,student.size());
            System.out.println("penalty : " + penalty);

            int max_timeslot = 0;
            
            for(int i = 0; i<timeslot.length; i++) {
                if(timeslot[i][1] > max_timeslot)
                    max_timeslot = timeslot[i][1];
            }
            
            //splitting timeslot 
            int[] index = new int[timeslot.length];
//            int[] slot = new int[timeslot.length];
            for (int i = 0; i < timeslot.length; i++) {
                for (int j = 0; j < timeslot[i].length; j++) {
                    index[i]=timeslot[i][0];
//                    slot[i]=timeslot[i][1];
                }
            }

            int [][] timeslot2 = new int[course.size()][2];
            timeslot2 = timeslot;
            double bestHill = hillclimbing(conflict_matrix, timeslot, student.size(), course.size(), max_timeslot, filename);
            

            
            System.out.println("penalty initial solution: "+penalty);
            System.out.println("penalty terbaik dari hill climbing: "+ bestHill);

            System.out.println("max timeslot : " + max_timeslot);
            
         
            
        } catch(Exception e) {
            System.out.println("error: " + e);
            e.printStackTrace();
        }
    }
    
    
    
    public static double penalty(int[][]conflict_matrix,int[][]timeslot,int student){
        double penalty = 0;
        for(int i=0;i<conflict_matrix.length-1;i++){
                for(int j=i+1;j<conflict_matrix.length;j++){
                    if(conflict_matrix[i][j]!=0){
                        if(Math.abs(timeslot[j][1]-timeslot[i][1])>=1 && Math.abs(timeslot[j][1]-timeslot[i][1])<=5){
                            penalty = penalty + (conflict_matrix[i][j]*(Math.pow(2, (5-(Math.abs(timeslot[j][1]-timeslot[i][1]))))));
                        }
                    }
                }
            }
        return penalty/(student);
    }
    public static boolean issafe2(int indexcourse, int ntimeslot, int conf[][], int[][]timeslot){
    for(int i=0; i<conf.length;i++)
        if(conf[indexcourse][i]!=0 && timeslot[i][1] == ntimeslot)
                    return false;
        return true;
    }
    
    public static boolean issafe(int index, int ntimeslot, int conf[][], int[][]sdegrees, int[][]timeslot){
    for(int i=0; i<sdegrees.length;i++)
        if(conf[sdegrees[index][0]-1][i]!=0 && timeslot[i][1] == ntimeslot)
                    return false;
        return true;
    }
    
    public static double hillclimbing (int conf[][], int[][]timeslot, int stu, int cour, int max, String filename){
    Random r = new Random();
        int randomindexcourse=0;
        int randomslot=0;
        int timeslottemp[][]=timeslot.clone();
        int newtimeslot[][]=timeslot.clone();
        double penalty1 = penalty(conf, newtimeslot, stu);
        double penalty2 = 0;
        double bestHill = 0;
        for (int i = 0; i < 1000; i++) {
            randomindexcourse=r.nextInt(cour);
            randomslot=r.nextInt(max);

            if (issafe2(randomindexcourse, randomslot, conf, newtimeslot)) {
                timeslottemp[randomindexcourse][1] = randomslot;
                penalty2 = penalty(conf, timeslottemp, stu);
                if(penalty1 > penalty2){
                    penalty1 = penalty(conf, timeslottemp, stu);
                    newtimeslot[randomindexcourse][1] = timeslottemp[randomindexcourse][1];
                }else{
                    timeslottemp[randomindexcourse][1] = newtimeslot[randomindexcourse][1];
                }
            }
            System.out.println("iterasi "+(i+1)+" penalty "+ penalty(conf, timeslottemp, stu));
            bestHill = penalty(conf, timeslottemp, stu);
        }
            export(timeslottemp,filename);
        return bestHill;

    }
    
    public static void export(int[][]timeslot, String filename){
        try{    
            FileWriter fw=new FileWriter("C:\\TORONTO\\"+filename+".sol");    
            for (int i = 0; i <timeslot.length; i++) {
                for (int j = 0; j <timeslot[i].length; j++) {
                    timeslot[i][0]=i+1;
                      fw.write(timeslot[i][j]+ " ");
                }
                fw.write("\n");  
            }
             
            fw.close();    
        } catch(Exception e){
            System.out.println(e);
        }    
            System.out.println("File "+filename+".sol berhasil disimpan di C");    
    }
    
}