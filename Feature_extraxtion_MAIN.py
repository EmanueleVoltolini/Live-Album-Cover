#%%
import numpy as np
import librosa
import scipy as sp
import IPython.display as ipd
import matplotlib.pyplot as plt
import os

import DEF_features


DATA_DIR="data"
assert os.path.exists(DATA_DIR), "wrong data dir"

filename_in=os.path.join(DATA_DIR, "song.m4a") # put whatever you like
audio, Fs = librosa.load(filename_in, sr=None)

ipd.Audio(audio, rate=Fs)

#%%
######################################SETTING PARAMETERS#
win_length = int(np.floor(0.01 * Fs))
hop_size = int(np.floor(0.075 * Fs))

window = sp.signal.get_window(window='hanning', Nx=win_length)

features_names = ['Zero Crossing Rate', 'Spectral Decrease', 'Spectral Centroid', 'Root mean square', 'Spectral Roll off']

#for beat tracking
t=np.arange(audio.size)/Fs

#%%
######################################COMPUTE FEATURES
win_number = int(np.floor((audio.shape[0] - win_length) / hop_size))

n_features = np.asarray(features_names).shape[0]

features = np.zeros((win_number, n_features))
for i in np.arange(win_number):
    frame = audio[i * hop_size : i * hop_size + win_length]
    frame_wind = frame * window
    
    spec = np.fft.fft(frame_wind)
    nyquist = int(np.floor(spec.shape[0] / 2))
    spec = spec[1:nyquist]
    freq = np.fft.fftfreq(n=win_length, d= 1/Fs)
    freq = freq[1:nyquist]
    
    features[i, 0] = compute_zcr(frame_wind, Fs)
    features[i, 1] = compute_specdec(spec)
    features[i, 2] = compute_speccentr(spec)
    features[i, 3] = compute_rms(spec, win_length,  hop_size)
    features[i, 4] = compute_specroll(spec, 0.85, freq)


#bpm, sample_beats = compute_beats_samp(audio, sr=Fs)

bpm, beats = compute_beats(audio, sr=Fs)
y_beats,sample_beats= beats_to_sample(beats, audio, sr=Fs)
print(bpm)

#%%
###################################### Plot the selected signal and features
plt.figure(figsize=(32, 16))

plt.subplot(n_features+1,1,1)
time_axis = np.arange(audio.shape[0]) / Fs
plt.plot(time_axis, audio)
plt.grid(True)
plt.title('audio')

plt.subplot(n_features+1,1,2)
feat_time_axis = np.arange(features.shape[0]) * hop_size / Fs
plt.title(features_names[0])
plt.plot(feat_time_axis, features[:, 0])
plt.grid(True)

plt.subplot(n_features+1,1,3)
feat_time_axis = np.arange(features.shape[0]) * hop_size / Fs
plt.title(features_names[1])
plt.plot(feat_time_axis, features[:, 1])
plt.grid(True)


plt.subplot(n_features+1,1,4)
feat_time_axis = np.arange(features.shape[0]) * hop_size / Fs
plt.title(features_names[2])
plt.plot(feat_time_axis, features[:, 2])
plt.grid(True);

plt.subplot(n_features+1,1,5)
feat_time_axis = np.arange(features.shape[0]) * hop_size / Fs
plt.title(features_names[3])
plt.plot(feat_time_axis, features[:, 3])
plt.grid(True);

plt.subplot(n_features+1,1,6)
feat_time_axis = np.arange(features.shape[0]) * hop_size / Fs
plt.title(features_names[4])
plt.plot(feat_time_axis, features[:, 4])
plt.grid(True);

#See if beats are correct
plt.figure(figsize=(32, 16))
plt.plot(t, audio, label="y")
plt.scatter(t[sample_beats], audio[sample_beats], label="beats", color="red")
plt.xlim([0, 5])
plt.xlabel("Time [s]")
plt.legend()
plt.show()

#%%
###################################### Smoothing process
#low pass
smooth_factor = 0.1
features_s=features
for i in range(win_number-1):
  for a in range(features.shape[1]):
    features_s[i+1][a]=smooth_factor*features_s[i+1][a]+(1-smooth_factor)*features_s[i][a]
features_s.shape

plt.figure(figsize=(32, 16))

plt.subplot(n_features+1,1,1)
time_axis = np.arange(audio.shape[0]) / Fs
plt.plot(time_axis, audio)
plt.grid(True)
plt.title('audio')

plt.subplot(n_features+1,1,2)
feat_time_axis = np.arange(features_s.shape[0]) * hop_size / Fs
plt.title(features_names[0])
plt.plot(feat_time_axis, features_s[:, 0])
plt.grid(True)

plt.subplot(n_features+1,1,3)
feat_time_axis = np.arange(features_s.shape[0]) * hop_size / Fs
plt.title(features_names[1])
plt.plot(feat_time_axis, features_s[:, 1])
plt.grid(True)


plt.subplot(n_features+1,1,4)
feat_time_axis = np.arange(features_s.shape[0]) * hop_size / Fs
plt.title(features_names[2])
plt.plot(feat_time_axis, features_s[:, 2])
plt.grid(True);

plt.subplot(n_features+1,1,5)
feat_time_axis = np.arange(features_s.shape[0]) * hop_size / Fs
plt.title(features_names[3])
plt.plot(feat_time_axis, features_s[:, 3])
plt.grid(True);

plt.subplot(n_features+1,1,6)
feat_time_axis = np.arange(features_s.shape[0]) * hop_size / Fs
plt.title(features_names[4])
plt.plot(feat_time_axis, features_s[:, 4])
plt.grid(True);

#%%
###################################### Mean, Max, min evaluation
features_mean = np.mean(features, 0)
features_Max= np.max(features, 0)
features_min = np.min(features, 0)
print(features_mean)
print(features_Max)
print(features_min)