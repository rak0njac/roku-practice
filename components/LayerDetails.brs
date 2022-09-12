sub init()
    m.btngrid = m.top.findNode("buttons")
    m.btngrid.observeField("itemSelected", "handleBtnPress")

    m.btncontent = createObject("roSGNode", "ContentNode")

    'for loop maybe
    m.button1content = m.btncontent.createChild("ContentNode")
    m.button2content = m.btncontent.createChild("ContentNode")
    m.button3content = m.btncontent.createChild("ContentNode")

    m.button1content.text = "Play"
    m.button2content.text = "Close"


    'end for

    m.btngrid.content = m.btncontent

    m.top.observeField("focusedChild", "handleFocus")
    m.top.observeField("content", "showDetails")
endsub

sub showDetails()
    m.top.findNode("imgPoster").uri = m.top.content.FHDPosterURL
    m.top.findNode("lbCast").text = "Cast: " + m.top.content.actors.Join(", ")
    m.top.findNode("lbYear").text = "Year: " + m.top.content.releasedate
    m.top.findNode("lbTitle").text = "Title: " + m.top.content.title
    m.top.findNode("lbGenres").text = "Genres: " + m.top.content.categories.Join(", ")
    m.top.findNode("lbLength").text = "Length: " + str(m.top.content.length)
    m.top.findNode("lbDirector").text = "Director: " + m.top.content.directors.Join(", ")
    m.top.findNode("lbRating").text = "Parental Rating: " + m.top.content.rating
    m.top.findNode("lbDescription").text = "Description: " + m.top.content.description

    if m.top.content.isFavorite then
        m.button3content.text = "Remove from favorites"
        else m.button3content.text = "Add to favorites"
    end if
end sub

sub handleFocus()
    if m.top.hasFocus() then
        m.btngrid.setFocus(true)
    end if
end sub

sub handleBtnPress()
    if m.btngrid.itemSelected = 0 then
        video = m.global.video
        video.content = m.top.content
    else if m.btngrid.itemSelected = 1 then
        m.top.visible = false
    else 
        addFavoriteToRegistry(m.top.content.id)
    endif
end sub

sub addFavoriteToRegistry(movieId as dynamic)
    reg = CreateObject("roRegistrySection", "General")
    assocFavorites = createObject("roAssociativeArray")

    if reg.Exists("Favorites") then
        favorites = reg.Read("Favorites")
        favorites = favorites.Split(", ")
    else
        favorites = createObject("roArray", 1, false)
    endif

    favorite = movieId

    for each entry in favorites
        assocFavorites[entry] = true
    end for

    if m.top.content.isFavorite then
        m.top.content.isFavorite = false
        m.button3content.text = "Add to favorites"
        assocFavorites.delete(favorite)
    else 
        m.top.content.isFavorite = true
        m.button3content.text = "Remove from favorites"
        assocFavorites[favorite] = true
    end if

    favorites = assocFavorites.Keys()
    favorites = favorites.Join(", ")
    reg.Write("Favorites", favorites)
    reg.Flush()

    print reg.Read("Favorites")
end sub