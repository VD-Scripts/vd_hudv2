function open() {
    $('.main_container').fadeIn(500);
}

function close() {
    $('.main_container').fadeOut(500);

}
var speedText = '';

window.addEventListener("message", function(event){
    let data = event.data
    if (data.type === "updateHud") {
        if(data.v === "cash") {
            document.getElementById("tbani").innerHTML = data.cash;
        } else if(data.v === "bank") {
            document.getElementById("tbank").innerHTML = data.b;
        } else if(data.v === "coins") {
            document.getElementById("tcoins").innerHTML = data.c;
        }
    }
    if (data.type === "toggle") {
        if(data.d) {
            document.getElementById("container").style.display = "block";
        } else {
            document.getElementById("container").style.display = "none";
        }
    }
    if (data.type === "updateTickets") {
        document.getElementById("tickets").style.display = "block";
        document.getElementById("tNumber").innerHTML = data.tickets;
    }
    if (data.type === "toggleMoney") {
        if (data.vazelina) {
            $("#banitari").fadeIn();
            // document.getElementById("banitari").style.display = "block";
        } else {
            $("#banitari").fadeOut();
            // document.getElementById("banitari").style.display = "none";
        }
    }
    if(data.type === "open") {
        open();
    }

    if(data.type === "close") {
        close();
    }
    if(data.type === "update")  {
        if(data.speed < 10) {
            speedText = "00" + Math.floor(data.speed);
        } else if(data.speed < 100){
            speedText = "0" + Math.floor(data.speed);
        } else if(data.speed >= 100){
            speedText = Math.floor(data.speed);
        }
        else {
            speedText = "000";
        }
        $('#vehicleSpeed').html(speedText);
        $('.progresturatii').css({ 'width': data.speedrpm + `%` })
        $("#vehicleFuel").text(`${data.fuel}%`);
        
        if (data.locked) {
            $('#lacat').attr('src','img/lacatinchis.png');
        } else {
            $('#lacat').attr('src','img/lacatdeschis.png');
        }

        if(data.engine) {
            $('#motoras').attr('src','img/motoras.png');
        }
        else{
            $('#motoras').attr('src','img/motorasstricat.png');
        }
    }
    // if(data.type === "updateViataArmura") {
    //     document.getElementById("vveata").style.width = `${data.viata}%`;
    //     document.getElementById("aarmura").style.width = `${data.armour}%`;
    //     // $('.vveata').css({ 'width': data.viata + `%` })
    //     // $('.aarmura').css({ 'width': data.armour + `%` })
    // }
});

close(true);