#U-Net model  
--

![image](https://github.com/user-attachments/assets/09d4ddf8-386b-486c-b256-52311dedf9be)  


* Train : 둘 다 잘 내려감 > 과적합 징후는 아직 없음!  
* validation : validation loss가 초반에 엄청 튀는 현상  
=> 학습 초반에 모델이 validation 데이터에 대해 완전 망했다가 나아지는 모습을 보임  
mean iou = 0.94로 꽤 높은 성능을 보임.


#encoderdecoder model   
--

![image](https://github.com/user-attachments/assets/1680e0f4-8ad9-4f19-8ed4-c396e74daea6)  

* Train : 둘 다 잘 감소 > 학습이 잘 되고 있음.
* val loss > 초반에 살짝 튀는데 바로 안정적으로 떨어짐 굿!  
=>처음에 살짝 불안했지만 학습이 꽤 안정적으로 되고 있음.  
mean iou = 0.67로 낮은 성능을 보임.  
그래프 상으로는 잘 안 나타나지만 mean iou는 낮아서 성능이 좋지 않음.

#pretrained u-net model 
--

![image](https://github.com/user-attachments/assets/0d329818-fdd8-4dc9-96c3-2aeb6dc168dc)  

* train : 급격하게 잘 내려감. 마지막엔 살짝 flatten 되면서 에포크가 부족할 수 있음.
* validation : 약간 튀는데 그래도 잘 내려감.
mean iou = 0.86로 꽤? 나쁘지 않음??  
epoch를 좀 더 늘려도 괜찮을 지도 모르겠다.  






