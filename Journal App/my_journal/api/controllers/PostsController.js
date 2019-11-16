// Dummy database
const post1 = {id: 1, 
    title: 'POST TITLE 1', 
    body: 'HERE IS MY BODY, DO WITH IT WHAT YOU WANT'}
const post2 = {id: 2, 
    title: 'POST TITLE 2', 
    body: 'BODY BODY BODY'}
const post3 = {id: 3, 
        title: 'POST TITLE 3', 
        body: 'BODY BODY BODY'}

const allPosts = [post1, post2, post3] 

module.exports = {
    posts: function(req, res) {
        res.send(allPosts)
    },

    create: function(req, res) {
        const title = req.param('title')
        const body = req.param('body')
        const newPost = {id: 4, title: title, body: body}

        sails.log.debug(title + ' ' + body)

        allPosts.push(newPost)
        res.end()
    },

    findById: function(req, res) {
        const postId = req.param('postId')
        const filteredPosts = allPosts
            .filter(p => {return p.id == postId})
        if (filteredPosts.length > 0) {
            res.send(filteredPosts[0])
        } else {
            res.send('Failed to find post ID: ' + postId)
        }
    }
}