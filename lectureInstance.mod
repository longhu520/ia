/************************
* Devoir PPC - M1 App 
* Binome : PIAO AL-Shikhley
*
* Fonctions de script utiles pour la lecture des fichiers d'instance
************************/

// NB comme pour n'importe quel langage de programmation, pour faciliter la 
// lisibilit¨¦ de votre code, n'h¨¦sitez pas ¨¤ le d¨¦composer en plusieurs 
// fonctions

execute{

/*Initialiser les scenes de chaque acte*/
function initActeScene(filePath){
	var f = new IloOplInputFile(filePath);
	if(f.exists){
		var s;
		while(!f.eof){
			var res ="";
			s = f.readline();
			if(s != ""){
				var t2 = convertStr(s);
				if(t2[0] == "bloc"){
					for(var s in pieceComplet){
						if(t2[1] == s){
							for(var i = 2; i < t2.length-1; i++){
								if(t2[i] != ""){
									acteScenes[s].add(t2[i]);
									scenes.add(t2[i]);		
								}							
							}
						}						
					}				
							
				}
			}
		}
		f.close;
	}else{
		writeln("the file " + filePath + "doesn't exist");
	}
}

/*Initialiser les intervenants de chaque scene*/
function initSceneIntervenant(filePath){
	var f = new IloOplInputFile(filePath);
	if(f.exists){
		var s;
		while(!f.eof){
			var res ="";
			s = f.readline();
			if(s != ""){
				var t2 = convertStr(s);
				if(t2[0] == "bloc"){
					for(var s in scenes){
						if(t2[1] == s){
							for(var i = 2; i < t2.length-1; i++){
								if(t2[i] != ""){
									intervenantsOfScene[s].add(t2[i]);
								}							
							}
						}						
					}				
							
				}
			}
		}
		f.close;
	}else{
		writeln("the file " + filePath + "doesn't exist");
	}
}

/*Initialiser chaque session*/
function initSession(filePath){
	var f = new IloOplInputFile(filePath);
	if(f.exists){
		var s;
		while(!f.eof){
			var res ="";
			s = f.readline();
			if(s != ""){
				var t2 = convertStr(s);
				if(t2[0] == "session"){
					for(var s in idSessions){
						if(t2[1] == s){
							dureeSession[s] = t2[2];	//implementer les durees de chaque session
							for(var i = 3; i< t2.length -1; i++){
								intervenantsOfSession[s].add(t2[i]);	//			
								
//								for(var scene in scenes){
//									if(t2[i] == scene){
//										intervenantsOfSession[s].add(intervenantsOfScene[scene]);							
//									}								
//								}							
							}
						}						
					}				
							
				}
			}
		}
		f.close;
	}else{
		writeln("the file " + filePath + "doesn't exist");
	}
}

/*Supprime toutes les tabulations et les espaces dans une chaine de caractere, puis renvois un tableau de chaines*/
function convertStr(str){
	var res = "";
	var t = str.split("\t");      //supprime toutes les tabulations dans une chaine
	for(var i = 0; i<t.length; i++){
					var t1 = t[i].split(" ");			//supprime ensuite toutes les espaces
					for(var j = 0; j < t1.length; j++){
						if(t1[j] != ""){
							res += t1[j];
							res += "/";						
						}					
					}			
				}
	var t2 = res.split("/");
	return t2;
}

function afficheTable(t){
	for(var i = 0; i < t.length; i++){
		writeln(i+":"+t[i]);
	}		
}

/*Initialiser les precedes*/
function initPrecede(filePath){
	var f = new IloOplInputFile(filePath);
	if(f.exists){
		var s;
		while(!f.eof){
			var res ="";
			s = f.readline();
			if(s != ""){
				var t2 = convertStr(s);	
				if(t2[0] == "precede"){
					if(t2.length <= 4)
						ords.add(t2[1],t2[2],0);
					else
						ords.add(t2[1],t2[2],parseInt(t2[3]));
				}
			}
		}
	}else{
		writeln("the file " + filePath + "doesn't exist");
	}
}

/*Initialiser les indisponibilites*/
function initIndispo(filePath){
	var f = new IloOplInputFile(filePath);
	if(f.exists){
		var s;
		while(!f.eof){
			var res ="";
			s = f.readline();
			if(s.indexOf("indisponible") != -1){		//traiter que les lines qui contienent "indisponible"
				var t1 = convertStr(s);
				var id = t1[1];
				var t2 = t1[2].split(",");
				for(var index=0; index<t2.length; index++){
					var t3 = t2[index].split("-");
					if(t3.length == 1){					//un entier designant un jour
						if(t1.length <= 4){				//aucun creneau est indiqu¨¦, indisponible toute la journ¨¦e
							for(var j=1; j<=c; j++){
								creneauIndispos[id].add(c*(t3[0]-1)+j);							
							}					
						}else{
							for(var i=3; i<t1.length-2; i++){
								creneauIndispos[id].add(c*(t3[0]-1)+t1[i]);			//les creneaux indisponibles sont indique						
							}						
						}					
					}else{								//une paire j1-j2
						var j1 = parseInt(t3[0]);
						var j2 = parseInt(t3[1]);
						for(var i=j1; i<=j2; i++){
							if(t1.length <= 4){
								for(var k=1;k<=c; k++){
									creneauIndispos[id].add(c*(i-1)+k);								
								}							
							}else{
								for(var l=3; l<=t1.length-2;l++){
									if(t1[l] != "")								
										creneauIndispos[id].add(c*(i-1)+parseInt(t1[l]));							
								}							
							}						
						}			
					}				
				}
			}
		}
		f.close;
	}else{
		writeln("the file " + filePath + "doesn't exist");
	}
}

function read(filePath) {
	var f = new IloOplInputFile(filePath);
	if(f.exists){
		var s;
		var indexBloc = 0;
		var indexSession = 0;
		var indexProcede = 0;
		while(!f.eof){
			var res="";
			s = f.readline();
			if(s != ""){								//ignore la ligne 'vide'
				var t2 = convertStr(s);

				if(t2[0] == "jour"){
					n = t2[1];
				}
				if(t2[0] == "crenaux"){
					c = t2[1];				
				}
				
				if(t2[0] == "bloc"){

					if(t2[1] == "pieceComplete"){
						//Initialiser les actes pour la picece complete					
						for(var i = 2; i < t2.length - 1; i++){
							if(t2[i] != ""){
								pieceComplet.add(t2[i]);				
							}						
						}
					}				
				}
				
				if(t2[0] == "session"){
					idSessions.add(t2[1]);				//stocker les Ids de session
				}
				
				if(t2[0] == "precede"){
				}
				
				if(t2[0] == "indisponible"){
					idIndispo.add(t2[1]);	
				}

 			}		
			
		}		
		f.close;	
	}else{
		writeln("the file " + filePath + "doesn't exist");	
	}
}
	
}



