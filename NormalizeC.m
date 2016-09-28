function NormalizeC()

if(GetWaveInC1Priority() == 2)  %(2P = 1)
    if(GetWaveInC2Priority() == 3)  %(3P = 2, 2P = 1, 1P = 3)
        if(GetWaveInC1()^2 + GetWaveInC2()^2 > 1)
            SetWaveInC1((1 - GetWaveInC2()^2)^0.5);
            SetWaveInC3(0);
        else
            SetWaveInC3((1 - GetWaveInC1()^2 - GetWaveInC2()^2)^0.5);
        end
    elseif(GetWaveInC3Priority() == 3)  %(3P = 3, 2P = 1, 1P = 2)
        if(GetWaveInC1()^2 + GetWaveInC3()^2 > 1)
            SetWaveInC1((1 - GetWaveInC3()^2)^0.5);
            SetWaveInC2(0);
        else
            SetWaveInC2((1 - GetWaveInC1()^2 - GetWaveInC3()^2)^0.5);
        end
    end
elseif(GetWaveInC2Priority() == 2)  %(2P = 2)
    if(GetWaveInC1Priority() == 3)  %(3P = 1, 2P = 2, 1P = 3)
        if(GetWaveInC1()^2 + GetWaveInC2()^2 > 1)
            SetWaveInC2((1 - GetWaveInC1()^2)^0.5);
            SetWaveInC3(0);
        else
            SetWaveInC3((1 - GetWaveInC1()^2 - GetWaveInC2()^2)^0.5);
        end
    elseif(GetWaveInC3Priority() == 3)  %(3P = 3, 2P = 2, 1P = 1)
        if(GetWaveInC2()^2 + GetWaveInC3()^2 > 1)
            SetWaveInC2((1 - GetWaveInC3()^2)^0.5);
            SetWaveInC1(0);
        else
            SetWaveInC1((1 - GetWaveInC2()^2 - GetWaveInC3()^2)^0.5);
        end
    end
elseif(GetWaveInC3Priority() == 2)  %(2P = 3)
    if(GetWaveInC1Priority() == 3)  %(3P = 1, 2P = 3, 1P = 2)
        if(GetWaveInC1()^2 + GetWaveInC3()^2 > 1)
            SetWaveInC3((1 - GetWaveInC1()^2)^0.5);
            SetWaveInC2(0);
        else
            SetWaveInC2((1 - GetWaveInC1()^2 - GetWaveInC3()^2)^0.5);
        end
    elseif(GetWaveInC2Priority() == 3)  %(3P = 2, 2P = 3, 1P = 1)
        if(GetWaveInC2()^2 + GetWaveInC3()^2 > 1)
            SetWaveInC3((1 - GetWaveInC2()^2)^0.5);
            SetWaveInC1(0);
        else
            SetWaveInC1((1 - GetWaveInC2()^2 - GetWaveInC3()^2)^0.5);
        end
    end
end