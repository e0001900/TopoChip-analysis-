function writeTiffStackMask(h,tr,tw,tags)
Mask = createMask(h);
location = ~Mask;
setDirectory(tr,1)
while true
    I = read(tr);
    I(location) = 0;
    figure,imshow(I)
    tw.setTag(tags)
    write(tw,I)
    if lastDirectory(tr)
        break
    end
    nextDirectory(tr)
    writeDirectory(tw)
end