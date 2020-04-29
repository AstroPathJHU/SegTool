function show_cell(cell_n, pairs_cnt, L1, L2, L3, c, opts)
%%
% show a single cell cell_n
%
%%
if opts == 1
    figure();
end
%
P1 = pairs_cnt(cell_n,1);
ax1 = subplot(2,2,1);
imshow(L1 == P1)
title('1')
%
P2 = pairs_cnt(cell_n,2);
ax2 = subplot(2,2,2);
imshow(L2 == P2)
title('2')
%
P3 = pairs_cnt(cell_n,3);
ax3 = subplot(2,2,3);
imshow(L3 == P3)
title('3')
%
ax4 = subplot(2,2,4);
imshow(uint8(c))
%
m1 = regionprops(L1 == P1,'centroid');
pp = m1.Centroid;
linkaxes([ax1,ax2,ax3, ax4])
axis([pp(1) - 50, pp(1) + 50, pp(2) - 50, pp(2) + 50])
%
end