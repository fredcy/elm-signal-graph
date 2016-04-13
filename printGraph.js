function printGraph(queue)
{
    queue = queue.slice(0);
        
    console.log('digraph { //');
    var seen = [];
    while (queue.length > 0)
    {
        var node = queue.pop();
        var id = node.id;
        if (seen.indexOf(id) < 0)
        {
            console.log('%d [label="%d: %s"]; //', id, id, node.name);
            var kids = node.kids || [];
            for (var i = kids.length; i--; )
            {
                console.log('%d -> %d', id, kids[i].id, '; //');
            }
            queue = queue.concat(kids);
            seen.push(id);

            // wrap the node's `notify` function to report on each call
            node.notify = wrapNotify(node.notify);
        }
    }
    console.log('} //');
}


function wrapNotify(notifyFn) {
    return function (timestamp, parentUpdate, parentID) {
        console.log("%d %d:%s %d->%s", timestamp, this.id, this.name, parentID, parentUpdate);
        notifyFn(timestamp, parentUpdate, parentID);
    };
}

