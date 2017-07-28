function openCity(evt, cityName) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
	
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(cityName).style.display = "block";
    evt.currentTarget.className += " active";
}


function myFunction() {
	var teste="Ricardo";
	var sobrenome="Felippe";
	var person = {firstName:"Tais", lastName:"Caroline", age:32, eyeColor:"black"};
	var objeto = { firstName: "John",    lastName : "Doe",
    id       : 5566,
    fullName : function() {
       return this.firstName + " " + this.lastName + " " + this.id;
    }
};
		// This is a Comment
		/*
	Multi-line comment
  		*/
	   name=objeto.fullName()
       //document.getElementById("CameCamel").innerHTML = "My First JavaScript-CameCamel";
	   document.getElementById("demo").innerHTML = "Paragraph changed.";
       debbuger;
	   document.getElementById("demo2").innerHTML = teste.length;
	   document.getElementById("demo3").innerHTML = teste.toUpperCase();
	   document.getElementById("demo4").innerHTML = teste.concat(" ",sobrenome);
	   document.getElementById("demo5").innerHTML = teste.charAt(1);
	   document.getElementById("demo6").innerHTML = myFunction2(2, 3);
	   document.getElementById("demo7").innerHTML = person.firstName+person.lastName;
	   document.getElementById("demo8").innerHTML = name;
	   
	   
   }
  
function myFunction2(p1, p2) {
    return p1 * p2;              // The function returns the product of p1 and p2
}

function myFunction3() {
	
     return  document.getElementById("demo9").innerHTML = Date();;              // The function returns the product of p1 and p2
}



