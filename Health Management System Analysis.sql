--HOSPITAL MANAGEMENT SYSTEM--

--(Patient Insights)

SELECT*FROM Patients

--How many Patients are registered in the Hospital--
 Select Count(patient_id) as NO_Of_Patients from Patients

 --Distribution of Patients by Blood Type--
 Select Count(patient_id)as Patient_Count,blood_type from Patients
 Group by blood_type

 --How Many Patients do not have Insurance--
 Select Concat(first_name,' ',last_name) as full_Name,insurance_number
 from Patients 
 where insurance_number='N/A'

 --Average age of Patients Visiting the Hospital--
 Select AVG(DATEDIFF(year,date_of_birth,getdate())) AS Average_age FROM Patients

 --Patient who have had more than 3 appointment in that past 6 month--

 Select P.patient_id,CONCAT(P.first_name,' ',P.last_name)as full_name,
 Count(A.appointment_id) as total_appointments from Patients P
 Join Appointments A on P.patient_id=A.patient_id
 where A.appointment_date>=DATEADD(month,-6,getdate())
 group by P.patient_id,CONCAT(P.first_name,' ',P.last_name)
 Having Count(A.appointment_id)>3


 --(Doctor Performance & Specialization)--
 Select*from Doctors
 select*from Appointments

 --Which Doctor handled the most Appointments
 Select top 1 D.doctor_id, CONCAT(D.first_name,' ',last_name) as Doc_fullName,D.specialization,
 count(A.appointment_id) as Total_appointments from Doctors D
 Join Appointments A on D.doctor_id=A.doctor_id
 Group by  D.doctor_id, CONCAT(D.first_name,' ',last_name), D.specialization
 

 --Avearge Consulation Fee for each specialization--
 select specialization,AVG(consultation_fee) as Avg_fee from Doctors
 GROUP BY specialization

 --Doctors with more than 10 YOE and a Consulation fee above average--
 select CONCAT(first_name,' ',last_name) as Doc_FullName,specialization, years_of_experience,consultation_fee from Doctors
 where years_of_experience>10
AND consultation_fee>
 (select AVG(consultation_fee)from Doctors)

 --Specialization with the highest number of Scheduled Appointment--
 Select top 1  D.specialization, 
 count(A.appointment_id) as Total_appointments from Doctors D
 Join Appointments A on D.doctor_id=A.doctor_id
 Group by   D.specialization
 

 --(Appointment Analysis)--
 select*from Appointments
 --What Percentage of Appointments were Canceled
Select 
	(COUNT(Case 
		When status ='Canceled'
		Then 1
		End)*100/Count(*)) AS canceled_appointments
From Appointments

--Which day of the week has the highest number of appointments--

Select top 1 FORMAT(appointment_date,'dddd')As day_of_week,
	Count(*) as total_appointments from Appointments
		Group by FORMAT(appointment_date,'dddd')
		Order by total_appointments desc

--Find the appointment hours that have the most appointments

select DATEPART(hour,appointment_date)as appointment_hour,
Count(*) as total_appointments from Appointments
group by DATEPART(hour,appointment_date)
order by total_appointments desc

--How many appointments were Scheduled per doctor in the  last month?

Select D.doctor_id,CONCAT(D.first_name,' ',D.last_name) as Doc_FullName,
		COUNT(A.appointment_id) as total_appointment from Doctors D
		JOIN Appointments A ON D.doctor_id=A.doctor_id
			where A.appointment_date=DATEADD(month,-1,getdate())
Group by D.doctor_id,CONCAT(D.first_name,' ',D.last_name)
ORDER BY total_appointment DESC

select*from Treatments