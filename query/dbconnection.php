<?php
function dbconnection(){
$conn= new mysqli("localhost","root","","karpool");

if($conn){
    echo "success";
}
else{
    echo "fail";
}
return $conn;
}

?>