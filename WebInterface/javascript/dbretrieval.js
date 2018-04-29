function retrieveTable(table_to_get) {

        if (window.XMLHttpRequest) {
            // code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        } else {
            // code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }

        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                document.getElementById(table_to_get).innerHTML = xmlhttp.responseText;
            }
        };
        xmlhttp.open("GET","getdata.php?q="+table_to_get,true);
        xmlhttp.send();

}
