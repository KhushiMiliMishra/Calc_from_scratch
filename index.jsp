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
    width: 300px;
    box-shadow:0 0 15px rgba(0,0,0,0.2);
}

.display{
    width:95%;
    height:55px;
    font-size:24px;
    margin-bottom:15px;
    text-align:right;
    padding:8px;
}

.buttons{
    display:grid;
    grid-template-columns:repeat(4,70px);
    gap:10px;
    justify-content:center;
}

button{
    height:55px;
    font-size:18px;
    cursor:pointer;
    border:none;
    border-radius:6px;
    background:#f2f2f2;
}

button:hover{
    background:#ddd;
}

.clear{
    grid-column: span 4;
    background:#ff6b6b;
    color:white;
}

.equals{
    background:#4CAF50;
    color:white;
}

.memory{
    background:#e6e6ff;
}

.result{
    margin-top:15px;
    font-size:16px;
}

.error{
    color:red;
}

.dark body{
    background:#121212;
}

.dark .calculator{
    background:#1e1e1e;
    color:white;
}

.dark .display{
    background:#2c2c2c;
    color:white;
}

.dark button{
    background:#333;
    color:white;
}

.dark button:hover{
    background:#444;
}

.dark .memory{
    background:#3a3a5a;
}

.dark .equals{
    background:#2e7d32;
}

.dark .clear{
    background:#c62828;
}

#themeButton{
    position:absolute;
    top:20px;
    right:20px;
    padding:10px 15px;
    border: 1px solid #1a0e7f;
    border-radius:5px;
    cursor:pointer;
}

</style>

<script>

function addToDisplay(value){
    document.getElementById("expression").value += value;
}

function clearDisplay(){
    document.getElementById("expression").value = "";
}

function toggleTheme(){
    document.body.classList.toggle("dark");
}

</script>

</head>

<body>

<button onclick="toggleTheme()" id="themeButton">
Theme
</button>

<div class="calculator">

<form method="post" action="calculate">

<input
type="text"
name="expression"
id="expression"
class="display"
autocomplete="off"
value="<%= request.getAttribute("result") != null ? request.getAttribute("result") : request.getParameter("expression") != null ? request.getParameter("expression") : "" %>"
/>

<div class="buttons">

<button type="button" class="clear" onclick="clearDisplay()">C</button>

<button class="memory" type="submit" name="action" value="MC">MC</button>
<button class="memory" type="submit" name="action" value="MR">MR</button>
<button class="memory" type="submit" name="action" value="M+">M+</button>
<button class="memory" type="submit" name="action" value="M-">M-</button>

<button type="button" onclick="addToDisplay('(')">(</button>
<button type="button" onclick="addToDisplay(')')">)</button>
<button type="button" onclick="addToDisplay('/')">/</button>
<button type="button" onclick="addToDisplay('*')">*</button>

<button type="button" onclick="addToDisplay('7')">7</button>
<button type="button" onclick="addToDisplay('8')">8</button>
<button type="button" onclick="addToDisplay('9')">9</button>
<button type="button" onclick="addToDisplay('-')">-</button>

<button type="button" onclick="addToDisplay('4')">4</button>
<button type="button" onclick="addToDisplay('5')">5</button>
<button type="button" onclick="addToDisplay('6')">6</button>
<button type="button" onclick="addToDisplay('+')">+</button>

<button type="button" onclick="addToDisplay('1')">1</button>
<button type="button" onclick="addToDisplay('2')">2</button>
<button type="button" onclick="addToDisplay('3')">3</button>
<button class="equals" type="submit">=</button>

<button type="button" onclick="addToDisplay('0')">0</button>
<button type="button" onclick="addToDisplay('.')">.</button>

</div>

</form>

<div class="result">

<p class="error">
<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
</p>

</div>

</div>

</body>
</html>