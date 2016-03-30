/************************
* Devoir PPC - M1 App 
* Binome : PIAO AL-Shikhley 
*
* Modele 1
* Description : TODO
*
************************/
using CP;
//{string} fichiersDonnees = ...;		/* ens des chemins vers les fichiers decrivant l'instance */

tuple Intervenant{
	string nom;
	{string} joursDispo;
}

tuple Session{
	string idS;
	int duree;
}

//Session session = ...;

tuple Precede{
	string s1;
	string s2;
	int jour;
}

tuple Indispo{
	string id;
	{int} jours;
}

int n; 									//le nombre de jours
int c; 									//le nombre de creneaux
{string} pieceComplet;
{string} scenes;
{string} acteScenes[pieceComplet];
{string} intervenantsOfScene[scenes];
{string} idSessions;
int dureeSession[idSessions];
{string} intervenantsOfSession[idSessions];
{string} idIndispo;
{int} creneauIndispos[idIndispo];
{Precede} ords = {};
{Indispo} indispos = {};


/************************************************************************
* Lecture du fichier d'instance
************************************************************************/

/* TODO 
Declaration des structures de donnees utiles pour lire 
les fichiers decrivant l'instance.
*/
include "lectureInstance.mod";
//include "dat/enonce.dat";


execute{
	// TODO - appeler la fonction que vous aurez definie et 
	// permettant de lire le contenu des fichiers decrivant l'instance, 
	// pour alimenter les structures de donnees que vous jugez utiles  	
	read("donnesInstances/syntaxe1.txt");
	initActeScene("donnesInstances/syntaxe1.txt");
	initSceneIntervenant("donnesInstances/syntaxe1.txt");
	initSession("donnesInstances/syntaxe1.txt");
	initPrecede("donnesInstances/syntaxe1.txt");
	read("donnesInstances/syntaxe2.txt");
	initIndispo("donnesInstances/syntaxe2.txt");
}

/************************************************************************
* Pretraitement sur les donnees de l'instance (si besoin)
************************************************************************/

/* TODO 
Declaration des structures de donnees utiles pour faciliter
l'expression du modele
*/
int maxFin = n*c;

/************************************************************************
* Variables de decision
************************************************************************/

/* TODO */
dvar interval session[ss in idSessions] in 0..maxFin size dureeSession[ss];
/************************************************************************
* Contraintes du modele 					(NB : ne peut etre mutualise)
************************************************************************/

/* TODO */
constraints{
	forall(p in ords){
		if(p.jour == 0){
			startBeforeStart(session[p.s1],session[p.s2]);		
		}else{
			startBeforeStart(session[p.s1],session[p.s2],p.jour);	
		}
	}
}

/************************************************************************
* Controle de flux  (si besoin)
************************************************************************/

/* TODO */

/************************************************************************
* PostTraitement
************************************************************************/

/* TODO */
execute{
	writeln("Jour=",n);
	writeln("Crenaux=",c);
	writeln("pieceComplet=",pieceComplet);
	writeln("acteScenes=",acteScenes);
	writeln("Scenes=",scenes);
	writeln("IntervenantOfScene=",intervenantsOfScene);
	writeln("Session=",idSessions);
	writeln("Duree=",dureeSession);
	writeln("IntervenantsOfSession=",intervenantsOfSession);
	writeln("Indispo=",idIndispo);
	writeln("JoursIndispo",creneauIndispos);
	writeln("Ords",ords);
}
