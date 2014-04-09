makeBoxes = function(startIndex, endIndex, storeId) {
    var boxes = [];
    var isLastIndex;
    var newStartIndex;
    var newEndIndex;
    var moreCommentAjaxRequest = $.ajax({
        url: 'HandleComment?action=getComment&storeId=' + storeId,
        type: 'POST',
        async: false,
        data: {
            startIndex: startIndex,
            endIndex: endIndex
        },
        // pass comment for load part of comment list 
        success: function(response) {
            var json = JSON.parse(response);
            for (var x in json['comments']) {
                var userId = json['comments'][x]['userId'];
                var userName = json['comments'][x]['userName'];
                var feedback = json['comments'][x]['feedback'];
                var postedDate = json['comments'][x]['postedDate'];


                var box = document.createElement('div');
                box.className = randomSize(feedback.length);


                $(box).append(
                        '<div style="display: flex;"><img style="margin: 5px;height:50px; id="personalInfo" src="icon/profle.png" title="User Photo"/>' +
                        '<div><a href=HandleUser?action=viewOtherUser&userId=' + userId + '>' + userName + '</a>' +
                        '<br/>' + postedDate + '</div></div><cpan>' + feedback + '</cpan>');

                // add box DOM node to array of new elements
                boxes.push(box);
            }

            $("#comment-display").append(boxes).nested("append", boxes);
            isLastIndex = json['isLastIndex'];
            newStartIndex = json['startIndex'];
            newEndIndex = json['endIndex'];
        }
    });
    var newCommentList = [{
            startIndex: newStartIndex,
            endIndex: newEndIndex,
            isLastIndex: isLastIndex
        }];

    return newCommentList;
};

function randomSize(length) {
    var boxSize = '' + 2 + (Math.ceil(Math.random() * 2) + 1);
    if (length < 28) {
        boxSize = '21';
        return 'box size' + boxSize;
    } else if (length > 60) {
        boxSize = '23';
        return 'box size' + boxSize;
    }
    
    return 'box size' + boxSize;
}


function submitComment(obj) {
    var commentValue = $(obj).siblings('textarea').val();
    var storeId = $(obj).attr('storeid');
    //get comment from textarea

    $.ajax({
        url: 'HandleComment?action=commentStore',
        type: 'POST',
        async: false,
        data: {
            storeId: storeId,
            comment: commentValue
        },
        // pass comment for load part of comment list 
        success: function(response) {
            window.console.log(response);
            //var json = JSON.parse(response);

        }
    });
    
    $("#comment-display").empty();
    getCommentFirstTime();
    //renew comment box!
}