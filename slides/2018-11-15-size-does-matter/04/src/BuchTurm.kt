package moin

fun main(args: Array<String>) {

    val buch_kg = 0.65
    val buch_hoehe_m = 0.02
    val buch_compressed_bytes = 270_000L

    // val big_repo_byte = 1_000_000_000L // 300 Gigabyte = Microsoft windows
    val big_repo_byte = 2_200_000_000L // 2,2 Gigabyte = Linux Kernel
    // val big_repo_byte = 300_000_000_000L // 300 Gigabyte = Microsoft windows
    val big_repo_gb = (big_repo_byte / 1e9).toLong()

    var num_books = (big_repo_byte / buch_compressed_bytes).toLong()

    val turm_hoehe_m = (num_books * buch_hoehe_m).toLong()
    val turm_gewicht_kg = (num_books * buch_kg).toLong()

    fun big(l : Long) = "%,d".format(l)

    println("${big(big_repo_gb)} GB könnte ${big(num_books)} Git-Bücher aufnehmen.")
    println("Das entspricht einem Turm von ${big(turm_hoehe_m)} Metern.")
    println("Mit einem Gewicht von ${big(turm_gewicht_kg)} Kilogramm.")
}