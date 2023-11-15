# DemoTodo

This is simple demo the show CRUD opertion using REST API function(GET , POST, PUT, DELETE). Although the server is not updating the record but I got the record updated locally . As far API Documentation is saying the POST , PUT , DELETE actually does not update any but for testing purpose if the we get status code 200 , that means it woking fine. Here is the API Doc link .

https://dummyjson.com/docs/todos. 

Here is the Json link for for encoding and decoding the json form API call. 

https://dummyjson.com/todos.

For this I have used the SwiftUI and MVVM architecture pattern to complete the coding challenge. The concurrecy was handle by using Swift async and await which is most recommended was to handle the concurrency. The  unit testing part is also written to make sure that the function is returning expected result.

Here is the screenshot when we run the app initially and it displaying the Todo List (GET request)..

<img width="390" alt="Screenshot 2023-11-14 at 15 06 52" src="https://github.com/MohammadHossanICT/DemoTodo/assets/100123501/be2201c7-adbe-4f9d-90bc-c483391040a9">

From the Top Right side I have added the sign to add the recoed into todo list . When user the lick the that plus sign it will redirect to add todo list. 

Here is the screenshot.

<img width="389" alt="Screenshot 2023-11-14 at 15 05 25" src="https://github.com/MohammadHossanICT/DemoTodo/assets/100123501/41092b7a-3555-4c57-8453-7fbefa4710d5">

Here is the screenshot when I added the add the record into todo list.

<img width="396" alt="Screenshot 2023-11-14 at 15 08 19" src="https://github.com/MohammadHossanICT/DemoTodo/assets/100123501/e1743038-3b37-422c-ba46-b5aae9cbaafb">

One the button is clicked then it will redirect  to list view and show the update result. Here is the screenshot that record is updated. 

<img width="387" alt="Screenshot 2023-11-14 at 15 10 26" src="https://github.com/MohammadHossanICT/DemoTodo/assets/100123501/9866a8b7-15e7-4406-afde-3028105a1769">

Update the values (isCompleted) . The user ID 2 is isCompleted equal to false . Here is the screenshot to udate task is completed(ID:2).

<img width="401" alt="Screenshot 2023-11-15 at 11 58 38" src="https://github.com/MohammadHossanICT/DemoTodo/assets/100123501/6bf486e0-df77-4083-a283-88b4524ff629">

Now when the swich button is clicked basically charging the values true. Here is the screenshot.. Please note that this record is already exist into API but we can not modify the new reacord which is added form Add to Do list.

<img width="368" alt="Screenshot 2023-11-14 at 19 07 57" src="https://github.com/MohammadHossanICT/DemoTodo/assets/100123501/0461cda0-d17a-4244-a93b-815e8d812b84">

To Delete the record user need to swip right to left then it will show the delete option then one the delete is click then record will be deleted. Please not that if the new record is  added and try to delete the new record it will return error beacuse it not present into API at that point needs to rerun the app again but the existing record will be updated by clicking the delete button. 


<img width="383" alt="Screenshot 2023-11-14 at 15 13 59" src="https://github.com/MohammadHossanICT/DemoTodo/assets/100123501/7c0fac47-2921-4515-9a4b-c33933040f6c">












