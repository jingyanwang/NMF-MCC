clc
close all
clear all

load wNMF_Input

[Output]=wNMF(Input, Options);

WeightImage=reshape(-Output.rho,32,32);
figure;
imagesc(WeightImage);
title('-rho')