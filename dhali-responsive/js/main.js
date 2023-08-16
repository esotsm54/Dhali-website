function toggleMenu(desiredState){
	const menu = document.getElementById("mobileMenu");
	if(desiredState == "open"){
		menu.classList.add("openMenu");
	}else{
		menu.classList.remove("openMenu");
	}
}