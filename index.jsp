<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Calculator</title>

<style>

body{
    font-family: Arial;
    background:#f0f0f0;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.calculator{
    background:white;
    padding:20px;
    border-radius:10px;
    box-shadow:0 0 10px rgba(0,0,0,0.2);
}

.display{
    width:100%;
    height:50px;
    font-size:22px;
    margin-bottom:10px;
    text-align:right;
    padding:5px;
}

.buttons{
    display:grid;
    grid-template-columns:repeat(4,60px);
    gap:10px;
}

button{
    height:50px;
    font-size:18px;
    cursor:pointer;
}

.result{
    margin-top:10px;
    font-size:18px;
}

.error{
    color:red;
}

</style>

<script>

function addToDisplay(value){
    document.getElementById("expression").value += value;
}

function clearDisplay(){
    document.getElementById("expression").value = "";
}

</script>

</head>

<body>

<div class="calculator">

<form method="post" action="calculate">

<input 
type="text"
name="expression"
id="expression"
class="display"
placeholder="Enter expression"
autocomplete="off"
/>

<div class="buttons">

<button type="button" onclick="addToDisplay('7')">7</button>
<button type="button" onclick="addToDisplay('8')">8</button>
<button type="button" onclick="addToDisplay('9')">9</button>
<button type="button" onclick="addToDisplay('/')">/</button>

<button type="button" onclick="addToDisplay('4')">4</button>
<button type="button" onclick="addToDisplay('5')">5</button>
<button type="button" onclick="addToDisplay('6')">6</button>
<button type="button" onclick="addToDisplay('*')">*</button>

<button type="button" onclick="addToDisplay('1')">1</button>
<button type="button" onclick="addToDisplay('2')">2</button>
<button type="button" onclick="addToDisplay('3')">3</button>
<button type="button" onclick="addToDisplay('-')">-</button>

<button type="button" onclick="addToDisplay('0')">0</button>
<button type="button" onclick="addToDisplay('.')">.</button>

<button type="submit">=</button>
<button type="button" onclick="addToDisplay('+')">+</button>

<button type="button" onclick="clearDisplay()">C</button>

</div>

</form>

<div class="result">

<h3>
Result: 
<%= request.getAttribute("result") != null ? request.getAttribute("result") : "" %>
</h3>

<p class="error">
<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
</p>

</div>

</div>

</body>
</html>