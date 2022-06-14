/**
 * 
 */


console.log("reply module");

var replyService = (function() { 
	var header = $("meta[name='_csrf_header']").attr("content");
	var token = $("meta[name='_csrf']").attr("content");
    function add(reply, callback, error) {
        console.log("reoly.add()");

        $.ajax({
            type : "post",
            url : "/replies/new",
            data : JSON.stringify(reply),
            contentType : "application/json; charset=utf-8",
            beforeSend: function(xhr){
                xhr.setRequestHeader(header, token);   
             },
            success : function(data) {
                if(callback)
                callback(data)
            },
            error : function(xhr, stat, er) {
                if(error) {
                    error(er);
                }
            }
        })
    }

    function getList(param, callback, error) {
        console.log("reply.getList()");
        var bno = param.bno; // 고정값
        var amount = param.amount || 10;
//        var lastRno = param.lastRno || 0;
        var lastRno = 0;
        var url = '/replies/' + bno + "/" + amount + "/" + lastRno;

        $.getJSON(url, function(data) {
        	console.log(lastRno);
            if(callback)
            callback(data)
        });
    }

    function remove(rno, callback, error) {
        console.log("reply.remove()");
        var url = '/replies/' + rno;

        $.ajax(url, {
            type : "delete",
            beforeSend: function(xhr){
                xhr.setRequestHeader(header, token);   
             },
        }).done(function(data) {
                if(callback)
                callback(data)
        })      
    }

    function modify(reply, callback, error) {
        console.log("reply.modify()");
        var url = '/replies/' + reply.rno;

        $.ajax(url, {
            type : "put",
            data : JSON.stringify(reply),
            contentType : "application/json; charset=utf-8",
            beforeSend: function(xhr){
                xhr.setRequestHeader(header, token);   
             },
            success : function(data) {
                if(callback)
                callback(data)
            }  
        })
    }

    function get(rno, callback, error) {
        console.log("reply.get()");
        var url = '/replies/' + rno;
       /* $.getJSON(url, function(data) {
            if(callback)
            callback(data)
        });*/
        $.ajax(url, {
            type : "get",
            contentType : "application/json; charset=utf-8",
            beforeSend: function(xhr){
                xhr.setRequestHeader(header, token);   
             },
            success : function(data) {
                if(callback)
                callback(data)
            },
            error : function(data) {
            	console.log("failed ajax get");
            }
        })
    }
    
    function displayTime(timeValue) {
        return moment().diff(moment(timeValue), 'days') < 1 ? moment(timeValue).format('HH:mm:SS') : moment(timeValue).format('YY/MM/DD') ;
    }



    return {
        name:"aaaa", 
        add:add,
        getList:getList,
        remove:remove,
        modify:modify,
        get:get,
        displayTime:displayTime        
    } 
})();