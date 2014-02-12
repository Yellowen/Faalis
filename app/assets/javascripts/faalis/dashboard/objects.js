function Time(value) {
    if( value !== undefined ){
        // parse value
        this.fromString(value);
    }
    else {
        this.hour = 0;
        this.minute = 0;
    }

    this.toString = function(){
        return this.hour + ":" + this.minute + " ";
    };

    this.fromString = function(value) {
        var time = value.split(":");
        this.set_hour(time[0]);
        this.set_minute(time[1]);
    };

    this.set_hour = function(value){
        if (value <= 23){
            this.hour = parseInt(value, 10);
        }else{
            this.hour = 0;
        }
    };

    this.set_minute = function(value){
        if (value <= 59){
            this.minute = parseInt(value, 10);
        }else{
            this.minute = 0;
        }
    };

}
