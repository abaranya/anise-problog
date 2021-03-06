#include<iostream>
#include<cstring>
#include<cstdio>
using namespace std;


/*
	Funcion procesar: procesa un archivo .raw, dependiendo de algun filtro si lo hay, 
					  dependiendo del endianess para la lectura, y permite tambien 
					  saltarse una cantidad de bytes indicados.
	
	Parametros:
					  dimx --> es tamanio de la dimension en x de la imagen a procesar

					  dimy --> es tamanio de la dimension en y de la imagen a procesar

					  dimz --> es tamanio de la dimension en z de la imagen a procesar

					  archivo_lectura --> es un apuntador a un arreglo de caracteres donde esta el nombre del archivo a leer

					  archivo_escritura --> es un apuntador a un arreglo de caracteres donde esta el nombre del archivo a escribir

					  prefijo --> se refiere al prefijo que hablamos para colocar al principio de cada tupla

					  sufijo --> es el sufijo que se coloca despues de cada tupla

					  endianess --> indica de que forma sera leido el archivo: false para Big Endian, y true para Little endian

					  saltar --> entero que indica la cantidad de bytes al saltar al principio del archivo, si es -1 no se 
					  			 saltan bytes y se leen los ultimos dimx*dimy*dimz*2 bytes

					  filtro --> entero que indica que valor de intensidad de una tupla no se quiere, es decir en el 
					  			 archivo de salida solo estaran las tuplas cuyo valor de intensidad no sea igual a filtro.
								 Si el valor es -1, significa que no se quiere un filtro.
	
*/
void procesar(int dimx, int dimy, int dimz, char *archivo_lectura,
				char *archivo_escritura,char *prefijo, char *sufijo, 
								bool endianess,int saltar,int filtro){

	FILE *file = fopen(archivo_lectura,"rb");
	if(file==NULL) fprintf(stderr,"Error al abrir el archivo de lectura");

	FILE *file2 = fopen(archivo_escritura,"w");
	unsigned short leido,aux;

	char leer[2];
	unsigned short intensity;

	if(saltar!=-1){
		if(fseek(file,saltar,SEEK_SET)) fprintf(stderr,"Error saltando bytes iniciales del archivo");
	}
	else{
		long tam =0;

		if(fseek(file,0,SEEK_END)) fprintf(stderr,"Error saltando bytes iniciales del archivo");

		tam = ftell(file);
		rewind(file);
		const long saltoDefault = tam - dimx * dimy * dimz *2;
		fprintf(stderr, "saltando inicialmente %ld bytes \n", saltoDefault);
		if(fseek(file,saltoDefault,SEEK_SET)) fprintf(stderr,"Error saltando bytes iniciales del archivo");

	}

	for(int k=0;k<dimz;k++)
		for(int j =0;j<dimy;j++)
			for(int i =0;i<dimx;i++){
			  fread(&intensity,sizeof(unsigned short),1,file);
					if(endianess){
					  //do swap
					  intensity = (intensity << 8) | (intensity >> 8);
					}
					if(filtro==-1 || (filtro!=-1 && (intensity>filtro)))
						fprintf(file2,"%s(%d,%d,%d,%hu)%s",prefijo,i,j,k,intensity,sufijo);
			}
		
	fclose(file);
	fclose(file2);
}

//Ejemplo de un main para procesar un archivo.
int main(){
	char archivo_lectura[200]="../raw-file/spm00_256x256x768.raw";
	char archivo_escritura[200]="salida2";
	char prefijo[200]="point";
	char sufijo[200]=".\n";
	const char separador=',';
	const char apertura_tupla='(';
	const char cerrar_tupla=')';
	const int dimx1=256; 
	const int dimy1=256; 
	//	const int dimz1=427; 
	const int dimz1=25; 
	procesar(dimx1,dimy1,dimz1,archivo_lectura,archivo_escritura,prefijo,sufijo,false,-1,-1);	

	return 0;
}
