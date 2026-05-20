# Cleanup
# Run as root, of course.

# ci spostiamo nella directory log.
cd /var/log
# redireziona il contenuto di null dentro al file messages sovrascrivendolo.
cat /dev/null > messages
# stessa cosa con wtmp
cat /dev/null > wtmp
# dopo la pulizia
# stampiamo il messaggio in out put 
echo "Log files cleaned up." 