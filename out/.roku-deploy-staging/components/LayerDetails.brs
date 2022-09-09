sub init()
    m.btngrid = m.top.findNode("buttons")
    m.btngrid.observeField("itemSelected", "handleBtnPress")

    m.btncontent = createObject("roSGNode", "ContentNode")
    m.button1content = m.btncontent.createChild("ContentNode")
    m.button2content = m.btncontent.createChild("ContentNode")

    m.button1content.text = "Play"
    m.button2content.text = "Close"

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
    else
        m.top.visible = false
    endif
end sub