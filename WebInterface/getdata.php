<!DOCTYPE html>
<html>
<head>
<style>
table {
    width: 100%;
    border-collapse: collapse;
}

table, td, th {
    border: 1px solid black;
    padding: 5px;
}

th {text-align: left;}
</style>
</head>
<body>

<?php
$q = ($_GET['q']);
$dbname = "PiSmartHome";
$con = mysqli_connect('localhost','root','root',$dbname);
if (!$con) {
    die('Could not connect: ' . mysqli_error($con));
}

mysqli_select_db($con,$dbname);

if ($q == "Checkins") {
  $sql="SELECT * FROM "."$dbname"."."."$q"." INNER JOIN Guests ON "."$q".".guest_id=Guests.guest_id";

} else {
  $sql="SELECT * FROM "."$dbname"."."."$q";
}
$result = mysqli_query($con,$sql);

if ($q == "Climate") {
  echo "<table> <h2> Climate </h2>
  <tr>
  <th>Date</th>
  <th>Time</th>
  <th>Temp (C)</th>
  <th>Temp (F)</th>
  <th>Indoor Humidity (%)</th>
  </tr>";
}
if ($q == "Movements"){
  echo "<table> <h2> Recent Movements </h2>
  <tr>
  <th>Date</th>
  <th>Time</th>
  <th>Room</th>
  <th>Area</th>
  </tr>";
}

if ($q == "Gas"){
  echo "<table>  <h2> Gas Detections </h2>
  <tr>
  <th>Date</th>
  <th>Time</th>
  </tr>";

}

if ($q == "Checkins"){
  echo "<table>  <h2> Home Check-ins </h2>
  <tr>
  <th>Name</th>
  <th>Relationship</th>
  <th>Date of entry</th>
  <th>Time of entry</th>
  </tr>";

}

if ($q == "Guests"){

  echo "<table>  <h2> Permitted Guestlist </h2>
  <tr>
  <th>Name</th>
  <th>Relationship</th>
  <th>Access restricted?</th>
  <th>Entry allowed from (time))</th>
  <th>Entry allowed until (time)</th>
  </tr>";
}


while($row = mysqli_fetch_array($result)) {

  if ($q == "Climate") {
    echo "<tr>";
    echo "<td>" . $row['date'] . "</td>";
    echo "<td>" . $row['time'] . "</td>";
    echo "<td>" . $row['temp_c'] . "</td>";
    echo "<td>" . $row['temp_f'] . "</td>";
    echo "<td>" . $row['humidity'] . "</td>";
    echo "</tr>";
  }

  if ($q == "Movements") {
    echo "<tr>";
    echo "<td>" . $row['date'] . "</td>";
    echo "<td>" . $row['time'] . "</td>";
    echo "<td>" . $row['room'] . "</td>";
    echo "<td>" . $row['area'] . "</td>";
    echo "</tr>";
  }

  if ($q == "Gas") {
    echo "<tr>";
    echo "<td>" . $row['date'] . "</td>";
    echo "<td>" . $row['time'] . "</td>";
    echo "</tr>";
  }

  if ($q == "Checkins") {
    echo "<tr>";
    echo "<td>" . $row['name'] . "</td>";
    echo "<td>" . $row['relationship_to_person'] . "</td>";
    echo "<td>" . $row['date'] . "</td>";
    echo "<td>" . $row['time'] . "</td>";
    echo "</tr>";
  }

  if ($q == "Guests") {
    echo "<tr>";
    echo "<td>" . $row['name'] . "</td>";
    echo "<td>" . $row['relationship_to_person'] . "</td>";
    echo "<td>" . $row['restricted_access'] . "</td>";
    echo "<td>" . $row['entry_allowed_from'] . "</td>";
    echo "<td>" . $row['entry_allowed_to'] . "</td>";
    echo "</tr>";
  }

}
if (!$result) {
    printf("Error: %s\n", mysqli_error($con));
    exit();
}
echo "</table>";
mysqli_close($con);
?>
</body>
</html>
