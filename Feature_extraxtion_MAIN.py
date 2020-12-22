#%%
import numpy as np
import librosa
import scipy as sp
import IPython.display as ipd
import matplotlib.pyplot as plt
import os

import json
import codecs

import argparse
import random
import time

from pythonosc import udp_client




import DEF_features
#%%
#ZCR
def compute_zcr(win, Fs):
    win_sign = np.sign(win)
    
    N = win.shape[0]
        
    sign_diff = np.abs(win_sign[:-1] - win_sign[1:])
    
    zcr = len(sign_diff[sign_diff != 0]) * Fs / N 
    
    # equivalent to
    
    zcr2 = np.sum(sign_diff) * Fs / (2 * N)
    return zcr
#SPECTRAL CENTROID
def compute_speccentr(spec):
    k_axis = np.arange(1, spec.shape[0] + 1)
    centr = np.sum(np.transpose(k_axis) * np.abs(spec)) / (np.sum(np.abs(spec))+np.finfo(np.float32).eps)
    return centr

def compute_specdec(spec):
    mul_fact  = 1 / (np.sum(np.abs(spec[1:]))+np.finfo(np.float32).eps)
    num = np.abs(spec[1:]) - np.tile(np.abs(spec[0]), len(spec) - 1)
    den = np.arange(1, len(spec))
    spectral_decrease = mul_fact * np.sum(num / den)
    return spectral_decrease


#beat tracking
from librosa.beat import beat_track

def compute_beats(y, sr):
    return beat_track(y, sr=sr)

#not using this because imprecise
def compute_beats_samp(y, sr):
    return beat_track(y, sr=sr, units='samples')


#this function is not used
def first_beat(y, sample_beats):#   ASSUMING WE HAVE A 4/4
    size4= sample_beats.size-(sample_beats.size%4) # closest multiple of 4
    beats4 = np.reshape(sample_beats[:size4],(-1,4))
    energy4 = np.mean(np.power(y[beats4],2), axis=0)
    return np.argmax(energy4)

#I'm  using this because I can set beat_track to output samples directlyb but they are not precise
from librosa import frames_to_samples
def beats_to_sample(beats, y, sr):
    """
    Aligning supposed beats to the peak of energy in the y signal

    beats:  np.ndarray
        frames index where beats are supposed to be
    y: np.ndarray
        input signal
    sr: int
        samplerate

    Returns
    y_beat: np.ndarray
        array with 1 when there is a beat
    beats_indices: np.ndarray
        array with indices of the beats
    """
    
    y_beat = np.zeros(y.shape)
    margin=int(0.1 * sr) 
    for beat in frames_to_samples(beats):
        bs_index = beat-margin +np.argmax(np.abs(y[beat-margin:beat+margin]))
        y_beat[bs_index]=1
    return y_beat, np.where(y_beat==1)[0]

def compute_rms(S):
  return np.sqrt(np.mean(np.abs(S)**2, axis=0, keepdims=True))

def compute_specroll(spec, perc, freq):
  spec= np.abs(spec)
  total_energy = np.cumsum(spec, 0)
  threshold = perc * total_energy[-1]
  ind = np.where(total_energy < threshold, np.nan, 1)
  return np.nanmin(ind*freq)

#%%

DATA_DIR="data"
assert os.path.exists(DATA_DIR), "wrong data dir"

filename_in=os.path.join(DATA_DIR, "song.mp3") # put whatever you like
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
    features[i, 3] = compute_rms(spec)
    features[i, 4] = compute_specroll(spec, 0.85, freq)


#bpm, sample_beats = compute_beats_samp(audio, sr=Fs)

bpm, beats = compute_beats(audio, sr=Fs)
y_beats,sample_beats= beats_to_sample(beats, audio, sr=Fs)
print(bpm)

#%%
###################################### Plot the selected signal and features
plt.figure(1, figsize=(16, 8))

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
plt.figure(2, figsize=(16, 8))
plt.plot(t, audio, label="y")
plt.scatter(t[sample_beats], audio[sample_beats], label="beats", color="red")
plt.xlim([0, 5])
plt.xlabel("Time [s]")
plt.legend()


#%%
###################################### Smoothing process
#low pass
smooth_factor = 0.1
features_s=features
for i in range(win_number-1):
  for a in range(features.shape[1]):
    features_s[i+1][a]=smooth_factor*features_s[i+1][a]+(1-smooth_factor)*features_s[i][a]
features_s.shape

plt.figure(3, figsize=(16, 8))

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
features_mean = np.mean(features_s, 0)
features_Max= np.max(features_s, 0)
features_min = np.min(features_s, 0)
print(features_mean)
print(features_Max)
print(features_min)

print(features_s.shape)
# %%
for x in range(features_s.shape[1]):
    features_s[:, x] = (features_s[:, x]-features_min[x])/(features_Max[x]-features_min[x])

# %%
data0= features_s[:, 0].tolist()
data1= features_s[:, 1].tolist()
data2= features_s[:, 2].tolist()
data3= features_s[:, 3].tolist()
data4= features_s[:, 4].tolist()

sample_beats_s = sample_beats*hop_size/Fs
data5 = sample_beats_s.tolist()

file_path = "data.json" ## your path variable
json.dump({'zcr': data0, 'specdec': data1, 'speccentr': data2, 'rms': data3, 'specroll': data4, 'hopsize_s': hop_size/Fs, 'beats': data5}, codecs.open(file_path, 'w', 
    encoding='utf-8'), separators=(',', ':'), sort_keys=False, indent=4)


# %%
#if __name__ == "__main__":
#
#    parser = argparse.ArgumentParser()
#    parser.add_argument("--ip", default="127.0.0.1",
#      help="The ip of the OSC server")
#    parser.add_argument("--port", type=int, default=5005,
#      help="The port the OSC server is listening on")
#    args = parser.parse_args()
#    
#    client = udp_client.SimpleUDPClient(args.ip, args.port)
#    client.send_message("/Fs", Fs)
#    client.send_message("/t", t)
#
#    for x in range(features_s.shape[1]):
#        client.send_message("/features_s", features_s[:][x])
#    for x in range(sample_beats.shape):
#        client.send_message("/beats", sample_beats[x])

#plt.show()
# %%
