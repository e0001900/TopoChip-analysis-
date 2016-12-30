function writeTiffStackMask(Mask,tr,tw,tags)
location = ~Mask;
setDirectory(tr,1)
while true
    I = read(tr);
    I(location) = 0;
    tw.setTag(tags)
    write(tw,I)
    if lastDirectory(tr)
        break
    end
    nextDirectory(tr)
    writeDirectory(tw)
end