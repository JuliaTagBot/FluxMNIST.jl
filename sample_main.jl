using FluxMNIST
using Flux: throttle

function main(args)
    model = FluxMNIST.Model()
    traindata, tX, tY = FluxMNIST.loadMNIST()
    accuracy = FluxMNIST.Accuracy(model.m)
    evalcb = throttle(() -> @show(accuracy(tX, tY)), 10)
    @time FluxMNIST.train!(model, traindata; cb=evalcb)
    @show(accuracy(tX, tY))
    FluxMNIST.savemodel(model)
end

abspath(PROGRAM_FILE) == @__FILE__() && main(ARGS)