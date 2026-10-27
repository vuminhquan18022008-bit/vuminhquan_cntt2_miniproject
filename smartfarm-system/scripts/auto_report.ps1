"===BAO CAO SU CO===" > ..\backup\bao-cao-su-co.txt
"===Ngay gio: $(Get-Date)===" >> ..\backup\bao-cao-su-co.txt
cat ..\log-he-thong.log | sls "ERROR|CRITICAL" >> ..\backup\bao-cao-su-co.txt
Write-Output "TONG SO SU CO" >> ..\backup\bao-cao-su-co.txt
(cat ..\log-he-thong.log | sls "ERROR|CRITICAL").Count >> ..\backup\bao-cao-su-co.txt