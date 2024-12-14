// ENFRENTAMIENTOS MAGICOS

class Mago {
    var objetosMagicos = []
    var poderInnato
    var property nombre
    var property resistenciaMagica
    var property energiaMagica
    var property categoria

    method poderTotal() = objetosMagicos.sum({objeto => objeto.poder(self)}) * poderInnato

    method disminuirEnergiaMagica(cantidad) { energiaMagica -= cantidad }

    method aumentarEnergiaMagica(cantidad) { energiaMagica += cantidad }

    method cambiarCategoria(nueva) { categoria = nueva }

    method desafiar(magoEnemigo) {
        if(magoEnemigo.categoria().esVencido(self, magoEnemigo)) {
            magoEnemigo.disminuirEnergiaMagica(magoEnemigo.categoria().puntosPerdidos(magoEnemigo))
            // Entiendo que mi reserva personal serian mis puntos de energia magica
            // Es decir que cuando venzo a otro mago, me transfiero (o gano) los puntos de energia magica que el perdio
            self.aumentarEnergiaMagica(magoEnemigo.categoria().puntosPerdidos(magoEnemigo))
        } // Si no lo vence, no hace nada
    }
}

object aprendiz {
    method esVencido(magoAtacante, magoEnemigo) = magoEnemigo.resistenciaMagica() < magoAtacante.poderTotal()

    method puntosPerdidos(magoEnemigo) = magoEnemigo.energiaMagica() / 2
}
object veterano {
    method esVencido(magoAtacante, magoEnemigo) = magoAtacante.poderTotal() >= 1.5 * magoEnemigo.resistenciaMagica()

    method puntosPerdidos(magoEnemigo) = magoEnemigo.energiaMagica() / 4
}
object inmortal {
    method esVencido(magoAtacante, magoEnemigo) = false
    
    method puntosPerdidos(magoEnemigo) = 0
}

// OBJETOS MAGICOS

class Varita {
    var poderBase

    method poder(mago) =
        if(mago.nombre().size().even()) {
            poderBase + (poderBase / 2)
        } else {
            poderBase
        }
}

class Tunica {
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

// GREMIOS DE MAGOS

class Gremio {
    var property miembros = []
    var esUnGremio = true

    method initialize() {
        if(miembros.size() < 2) { self.error("Miembros insuficientes")}
    }

    method poderTotal() = miembros.sum({ miembro => miembro.poderTotal() })

    method energiaMagica() = miembros.sum({ miembro => miembro.energiaMagica()})

    method lider() = miembros.max({ miembro => miembro.poderTotal() })

    method totalEnergiaPerdida() = miembros.sum({ miembro => miembro.categoria().puntosPerdidos(miembro) })

    method perderEnergiaPorMiembro() = miembros.forEach({ miembro => miembro.disminuirEnergiaMagica(miembro.categoria().puntosPerdidos(miembro)) })

    method esVencido(atacante) = atacante.poderTotal() > (self.energiaMagica() + self.lider().energiaMagica())

    method desafiarGremio(gremioEnemigo) {
        if(gremioEnemigo.esVencido(self)) { 
            self.lider().aumentarEnergiaMagica(gremioEnemigo.totalEnergiaPerdida())
            gremioEnemigo.perderEnergiaPorMiembro()
        } // No me dicen que pasa si pierdo como gremio
    }

    method desafiarMago(magoEnemigo) {
        // Si yo como gremio desafie a un mago y NO me vencieron, significa que gane como gremio
        if(!self.esVencido(magoEnemigo)) {
            magoEnemigo.disminuirEnergiaMagica(magoEnemigo.categoria().puntosPerdidos(magoEnemigo))
            self.lider().aumentarEnergiaMagica(magoEnemigo.categoria().puntosPerdidos(magoEnemigo))
        } // No me dicen que pasa si pierdo como gremio
    }
}

// 3.
/* 
    Con mi implementacion actual va a dar fallos si es que uno de los miembros del gremio
    contiene otro gremio como miembro y trato de buscar el lider del gremio principal, 
    pero no pude pensar en una solucion para ello
*/