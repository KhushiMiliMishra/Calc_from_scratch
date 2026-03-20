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
    width:300px;
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

.error{
    color:red;
    margin-top:10px;
    text-align:center;
}

/* DARK MODE */
.dark{
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
    border:1px solid #1a0e7f;
    border-radius:5px;
    cursor:pointer;
}
</style>

<script>
function addToDisplay(value){
    let display = document.getElementById("expression");

    // If current value is 0 or 0.0, replace instead of append
    if(display.value === "0" || display.value === "0.0"){
        display.value = value;
    } else {
        display.value += value;
    }
}

function clearDisplay(){
    document.getElementById("expression").value = "";
}

function toggleTheme(){
    document.body.classList.toggle("dark");

    if(document.body.classList.contains("dark")){
        localStorage.setItem("theme", "dark");
    } else {
        localStorage.setItem("theme", "light");
    }
}

function backspace(){
    let display = document.getElementById("expression");
    display.value = display.value.slice(0, -1);
}

document.addEventListener("keydown", function(event){
    if(event.key === "Enter"){
        event.preventDefault();
        document.querySelector("form").submit();
    }
});

window.onload = function(){

    // Restore theme
    const savedTheme = localStorage.getItem("theme");
    if(savedTheme === "dark"){
        document.body.classList.add("dark");
    }

    let input = document.getElementById("expression");
    input.focus();
    input.setSelectionRange(input.value.length, input.value.length);
};
</script>

</head>

<body>

<button onclick="toggleTheme()" id="themeButton">Theme</button>

<div class="calculator">

<form method="post" action="calculate">

<input
type="text"
name="expression"
id="expression"
class="display"
autocomplete="off"
value="<%= 
    session.getAttribute("result") != null ? session.getAttribute("result") : 
    session.getAttribute("expression") != null ? session.getAttribute("expression") : "" 
%>"
/>

<div class="buttons">

<button type="button" class="clear" onclick="clearDisplay()">C</button>
<button type="button" onclick="backspace()">⌫</button>

<button class="memory" type="submit" name="action" value="MC">MC</button>
<button class="memory" type="submit" name="action" value="MR">MR</button>
<button class="memory" type="submit" name="action" value="M+">M+</button>
<button class="memory" type="submit" name="action" value="M-">M-</button>

<button type="button" onclick="addToDisplay('(')">(</button>
<button type="button" onclick="addToDisplay(')')">)</button>
<button type="button" onclick="addToDisplay('%')">%</button>
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

<p class="error">
<%= session.getAttribute("error") != null ? session.getAttribute("error") : "" %>
</p>

<%
/* CLEAR AFTER DISPLAY (IMPORTANT) */
session.removeAttribute("result");
session.removeAttribute("error");
session.removeAttribute("expression");
%>

</div>

</body>
</html>