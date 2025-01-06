I watch [How history words](https://www.youtube.com/@HowHistoryWorks) on Youtube. They end every video with a link to another video from the creator that I assume help generate more views. However, there's no obvious pattern (and if there is I'm going to pretend like there isn't for math's sake) to which video points to which other one. Here it is drawn out, if video A has a pointer to video B:

    Video A ---> Video B

I think that each video points to at most one video (I've seen some that don't point to any), but I don't know that there are no two (or more?) videos that point to the same video. So, this situation is possible:

Video A-
        |
        ->  Video C
Video B-|


So, if we put it in graph theory terms, it is a directed graph with each vertex of any in degree and out degree of at most one. How history works has 128 videos published at the time I'm writing this which is 2^7 (I'm going to figure out how to make that important later). I could write code to figure things out about this graph, but I'm instead going to assume it's a random digraph with the properties I said before. 

I know nothing about random graphs and, keeping with my refusing to google things hobby, here is my best attempt. Firstly, I should define what random means in this context, with A being the set of all videos. 

1. The vertex set V and edge set E satisfy the rules of out degree at most 1
2. Each vertex (video) has a uniformly randomly chosen subset* of A as it's in edge
3. Each vertex has at most one randomly chose out edge, to a node randomly chosen from A or {{}}, each with 50% probability

* uniformly randomly chosen = random index of power set of A

If I want to refuse to google things, I should probably also avoid Youtube, a Google product. I guess my goal needs to be to figure out how many guesses I need to figure out things about this graph. I have a two questions:

1. What is the max/min of the in degree of any vertex?
2. Are there any cycles?

The first one feels like it should be much easier than the second to get with a few googles (hopefully). With one google, I learn the out edge of a single vertex.
