// ENFRENTAMIENTOS MAGICOS

class Mago {
    var objetosMagicos = []
    var poderInnato
    var property nombre
    var property resistenciaMagica

    method poderTotal() = objetosMagicos.poder(self).sum() * poderInnato

    method disminuirResistencia(cantidad) = resistenciaMagica - cantidad

    method aumentarResistencia(cantidad) = resistenciaMagica + cantidad

    method desafiar(magoEnemigo) {
        if(magoEnemigo.esVencido()) {
            
        }
    }
}

// OBJETOS

class varita {
    var poderBase

    method poder(mago) =
        if(mago.nombre().size().even()) {
            poderBase + (poderBase / 2)
        } else {
            poderBase
        }
}

class tunica {
    var poderBase
    var tipo

    method poder(mago) = poderBase + tipo.poderExtra(mago)
}
object comun {
    method poderExtra(mago) = 2 * mago.resistenciaMagica()
}
object epica {
    method poderExtra(mago) = 2 * mago.resistenciaMagica() + 10
}

class amuleto {
    method poder(mago) = 200
}

object ojota {
    method poder(mago) = 10 * mago.nombre().size()
}

