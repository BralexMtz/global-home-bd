from django.shortcuts import render
from django.http import HttpResponse
from .scripts import registro_usuario as registro_s
from .scripts import ver_usuario as veer
# Create your views here.
def index(request):
    return render(request, 'index.html')

def registro(request):
    if request.method == 'POST':
        nombre=request.POST['Nombre']
        ap_paterno=request.POST['Ap_paterno']
        ap_materno=request.POST['Ap_materno']
        email=request.POST['Email']
        nombre_usuario=request.POST['Nombre_usuario']
        contrasenia=request.POST['Contrasenia']
        numero=request.POST['Numero']
        registro_s.insert(nombre,ap_paterno,ap_materno,email,nombre_usuario,contrasenia,numero)
        return render(request, 'registro_usuario.html',{"mensaje":"Se registro con éxito"})

    return render(request, 'registro_usuario.html')


def busqueda(request):
    diccionario={}
    if request.method == 'POST':
        usuario=request.POST['Username']
        diccionario=veer.ver(usuario)
        if not diccionario:
            return render(request, 'ImprimirUsuario.html')
    return render(request, 'ImprimirUsuario.html',diccionario)