function newColourValue = quantizeColour(colourValue, quantLevel)
    newColourValue = floor(colourValue/quantLevel) * quantLevel + quantLevel/2;
end

