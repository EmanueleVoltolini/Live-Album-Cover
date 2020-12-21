#%%
import numpy as np
import librosa
import scipy as sp
import IPython.display as ipd
import matplotlib.pyplot as plt
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

#%%
#SPECTRAL CENTROID
def compute_speccentr(spec):
    k_axis = np.arange(1, spec.shape[0] + 1)
    centr = np.sum(np.transpose(k_axis) * np.abs(spec)) / np.sum(np.abs(spec))
    return centr


#%%
def compute_specdec(spec):
    mul_fact  = 1 / np.sum(np.abs(spec[1:]))
    num = np.abs(spec[1:]) - np.tile(np.abs(spec[0]), len(spec) - 1)
    den = np.arange(1, len(spec))
    spectral_decrease = mul_fact * np.sum(num / den)
    return spectral_decrease


#%%
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


#%%
#rms
def compute_rms(S, frame_length, hop_length):
  return librosa.feature.rmse(S=S, frame_length=frame_length, hop_length=hop_length)

#%%
def compute_specroll(spec, perc, freq):
  spec= np.abs(spec)
  total_energy = np.cumsum(spec, 0)
  threshold = perc * total_energy[-1]
  ind = np.where(total_energy < threshold, np.nan, 1)
  return np.nanmin(ind*freq)