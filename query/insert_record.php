<?php

include("dbconnection.php");
$con=dbconnection();

if(isset($_POST["name"])){
    $name=$_POST["name"];
}
else return;

if(isset($_POST["password"])){
    $email=$_POST["password"];
}
else return;

if(isset($_POST["phone"])){
    $email=$_POST["phone"];
}
else return;

if(isset($_POST["email"])){
    $email=$_POST["email"];
}
else return;

$query= "INSERT INTO `user_table`( `uname`, `upassword`, `uphone`, `uemail`)
VALUES ('$name','$password','$phone','$email')";

$exe=mysqli_query($con,$query);

$arr=[];
if($exe)
{
    $arr["success"]="true";
}
else
{
    $arr["success"]="false";
}
print(json_encode($arr));
?>