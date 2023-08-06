<!DOCTYPE html>
<html lang="en">
<meta charset="UTF-8">  
<style>
table, th, td {border: 1px solid black;}  
input[type=text], select, textarea {
  width: 100%;
  padding: 12px 20px;
  border: 2px solid #ccc;
  border-radius: 4px;
  resize: vertical;
  float: left;
  margin-top: 6px;
  height: 150px;
  box-sizing: border-box;
  font-size: 16px;
  resize: none;}
</style>

<body>
<h1>Efosa Osagiede</h1>
<p>Enter SQL Statement:</p>

<form method = "post">
  <textarea id="querybox" name="querybox" placeholder="Enter your SQL query here..." style="height:200px"></textarea><br>
  <input type="submit" name = "runquery" value="Run query">
  <input type="submit" value="Start Over" onclick="javascript:eraseText();">
</form>

<script>
function eraseText() {
    document.getElementById("querybox").value = "";
    window.location.reload(true);}
</script>
<br>

<?php
// Create connection
$user = 'root';
$pass = 'iz^yuOLc)7#bD[/"';
$inst = '/cloudsql/friendly-retina-369902:us-central1:myinstance';
$db = 'MySports';

$conn = mysqli_connect(null, $user, $pass, $db, null, $inst);

// Check connection
if($conn != null) {
  echo "Connected to database! <br><br>";}
else {
  echo "Connection failed! <br><br>";}

//Classify query
if(array_key_exists('runquery', $_POST)) {
  $sql = $_POST['querybox'];

  if(startsWith($sql, "SELECT") || startsWith($sql,"select")){ select_query();}
  else if(startsWith($sql, "INSERT INTO") || startsWith($sql,"insert into")) {insert_query();}
  else if(startsWith($sql, "CREATE TABLE") || startsWith($sql,"create table")) {create_table_query();}
  else if(startsWith($sql, "UPDATE") || startsWith($sql,"update") || startsWith($sql, "ALTER") || startsWith($sql,"alter")) {update_query();}
  else if(startsWith($sql, "DELETE FROM") || startsWith($sql,"delete from")) {delete_query();}
  else if(startsWith($sql, "DROP") || startsWith($sql,"drop")) {drop_query();}
  else {echo "Invalid query!";}
} 

function startsWith ($string, $startString){
    $len = strlen($startString);
    return (substr($string, 0, $len) === $startString);
}

function select_query()  {
  global $sql, $conn;
  $result = $conn->query( $sql);

  //Display query statement
  echo "SELECT query: '" . $sql . "'<br><br>";

  if ($result->num_rows > 0) {
    echo "Number of rows retrieved: " . $result->num_rows . "<br><br>";
    while($rand = mysqli_fetch_assoc($result)){
      $resultset[]=$rand;
    }
    $htmls = "<table><tr><th>".implode('</th><th>',array_keys($resultset[0])).'</th></tr>';
    foreach($resultset as $set){
        $htmls .= "<tr><td>".implode('</td><td>',$set).'</td></tr>';
    }
    print $htmls.'</table>';
  } 
  else {
    echo "No results";
  }  
  $conn->close();
}

function insert_query()  {
  global $sql, $conn;

  //Display query statement
  echo "INSERT query: '" . $sql . "'<br><br>";

  if ($conn->multi_query($sql) === TRUE) {
    echo "New row inserted!";
  } 
  else {
    echo "Error: " . $sql . "<br>" . $conn->error;
  }  
  $conn->close();
}

function create_table_query()  {
  global $sql, $conn;

  //Display query statement
  echo "CREATE TABLE query: '" . $sql . "'<br><br>";
  
  if ($conn->multi_query($sql) === TRUE) {
    echo "Table created!";
  } else {
    echo "Error creating table: " . $conn->error;
  }
  $conn->close();
}

function update_query()  {
  global $sql, $conn;

  //Display query statement
  echo "UPDATE query: '" . $sql . "'<br><br>";

  if ($conn->multi_query($sql) === TRUE) {
    echo "Table updated!";
  } else {
    echo "Error creating table: " . $conn->error;
  }
  $conn->close();
}

function delete_query()  {
  global $sql, $conn;

  //Display query statement
  echo "DELETE query: '" . $sql . "'<br><br>";

  if ($conn->multi_query($sql) === TRUE) {
    echo "Record deleted!";
  } else {
    echo "Error deleting record: " . $conn->error;
  }
  $conn->close();
}

function drop_query()  {

  //Display query statement
  echo "DROP query: '" . $sql . "'<br><br>";

  echo "DROP statements are not accepted!";
  $conn->close();
}

?>

</body>
</html>